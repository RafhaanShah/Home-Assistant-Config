# Vacuum Per-Room Cleaning — Design Plan

Goal: drive **complex, frequency-aware vacuum schedules** where each room is cleaned
only when "enough" time has passed since it was last cleaned — built on **generic HA
`vacuum.*` actions and Areas** so it stays portable if the vacuum is ever replaced.

Vacuum entity: `vacuum.dreamevac` (Dreame, `custom_components/dreame_vacuum`).

---

## 1. Design principle: stay vacuum-agnostic

We deliberately avoid the Dreame-specific `dreame_vacuum.vacuum_clean_segment` (segment
IDs) and instead use the **generic** action:

```yaml
action: vacuum.clean_area
target:
  entity_id: vacuum.dreamevac
data:
  cleaning_area_id:
    - living_room # HA area_id values
    - kitchen
```

Because `cleaning_area_id` takes **Home Assistant `area_id`s** directly, the whole system
is keyed on HA Areas — no segment-ID mapping layer is needed. The Dreame room names have
been renamed to match HA Areas 1:1 (incl. _Hallway_), so the integration resolves areas
to its own segments internally.

Get an `area_id` from a human name with the template function:

```jinja
{{ area_id("Living Room") }}   {# -> ff9921762b0b4bf4905373cd187c727e #}
```

> **Verify first:** confirm the Dreame integration actually implements `vacuum.clean_area`
> (call it once for a single area and check it cleans). If a future/!current vacuum lacks
> it, only the single service call in the script (3a) needs swapping — everything else is
> generic.

### Reference: current Dreame segment ↔ Area (informational only)

| Segment | Room / HA Area |
| ------: | -------------- |
|       4 | Kitchen        |
|       5 | Living Room    |
|       6 | Bathroom       |
|       7 | Bedroom        |
|       8 | Hallway        |
|       9 | Guest Bathroom |
|      10 | Guest Room     |
|      11 | Office         |

Segment IDs are no longer referenced anywhere in the config; listed only for debugging.

---

## 2. Helper entities to create

### 2a. Per-room "last cleaned" timestamps — `input_datetime` (one per room)

Survives restarts, UI-editable, trivial to use in native conditions/templates.

Files in `entities/input_datetime/` (loaded by `integrations/input_datetime.yaml`):

```
vacuum_last_cleaned_kitchen.yaml
vacuum_last_cleaned_living_room.yaml
vacuum_last_cleaned_bathroom.yaml
vacuum_last_cleaned_bedroom.yaml
vacuum_last_cleaned_hallway.yaml
vacuum_last_cleaned_guest_bathroom.yaml
vacuum_last_cleaned_guest_room.yaml
vacuum_last_cleaned_office.yaml
```

Each:

```yaml
name: Vacuum Last Cleaned Kitchen
has_date: true
has_time: true
```

### 2b. Room config (frequency + last-cleaned link) — `sensor` template

Single source of truth, keyed by **HA area name** (human-readable, portable). No area_id
or segment is hardcoded — `area_id()` resolves the name at use time.

File: `entities/template/sensor/vacuum_rooms.yaml`

```yaml
# https://www.home-assistant.io/integrations/template/#sensor
sensor:
  - name: Vacuum Rooms
    state: "{{ state_attr('sensor.vacuum_rooms', 'rooms') | count }}"
    attributes:
      rooms: >
        {{
          [
            {"area": "Kitchen",        "frequency_days": 2, "last_cleaned": "input_datetime.vacuum_last_cleaned_kitchen"},
            {"area": "Living Room",    "frequency_days": 2, "last_cleaned": "input_datetime.vacuum_last_cleaned_living_room"},
            {"area": "Bathroom",       "frequency_days": 1, "last_cleaned": "input_datetime.vacuum_last_cleaned_bathroom"},
            {"area": "Bedroom",        "frequency_days": 3, "last_cleaned": "input_datetime.vacuum_last_cleaned_bedroom"},
            {"area": "Hallway",        "frequency_days": 2, "last_cleaned": "input_datetime.vacuum_last_cleaned_hallway"},
            {"area": "Guest Bathroom", "frequency_days": 7, "last_cleaned": "input_datetime.vacuum_last_cleaned_guest_bathroom"},
            {"area": "Guest Room",     "frequency_days": 7, "last_cleaned": "input_datetime.vacuum_last_cleaned_guest_room"},
            {"area": "Office",         "frequency_days": 3, "last_cleaned": "input_datetime.vacuum_last_cleaned_office"}
          ]
        }}
```

> Frequencies are placeholders — tune per room (bathroom daily, guest rooms weekly, etc.).

### 2c. "Rooms due for cleaning" — `sensor` template (computed)

Outputs the list of overdue **area_ids**, ready to drop straight into `cleaning_area_id`.

> **Cleaning order:** the order rooms are listed in `sensor.vacuum_rooms` (2b) **is** the
> cleaning order. This sensor iterates that list top-to-bottom, so the emitted `area_ids`
> preserve it, and `vacuum.clean_area` passes them to the robot in order (the Dreame
> integration appends segments in list order — see `async_clean_segments`). To change the
> order, just reorder the rows in 2b. No separate helper is needed, and we deliberately
> avoid the Dreame-specific `vacuum_set_cleaning_sequence` to stay portable.

File: `entities/template/sensor/vacuum_rooms_due.yaml`

```yaml
sensor:
  - name: Vacuum Rooms Due
    state: "{{ state_attr('sensor.vacuum_rooms_due', 'area_ids') | count }}"
    attributes:
      area_ids: >
        {% set ns = namespace(due=[]) %}
        {% for r in state_attr('sensor.vacuum_rooms', 'rooms') %}
          {% set lc = states(r.last_cleaned) %}
          {% if lc in ['unknown','unavailable',''] or
                (now() - as_datetime(lc)).total_seconds() >= r.frequency_days * 86400 %}
            {% set ns.due = ns.due + [area_id(r.area)] %}
          {% endif %}
        {% endfor %}
        {{ ns.due }}
      areas: >
        {# human-readable mirror for dashboards/notifications #}
        {% set ns = namespace(due=[]) %}
        {% for r in state_attr('sensor.vacuum_rooms', 'rooms') %}
          {% set lc = states(r.last_cleaned) %}
          {% if lc in ['unknown','unavailable',''] or
                (now() - as_datetime(lc)).total_seconds() >= r.frequency_days * 86400 %}
            {% set ns.due = ns.due + [r.area] %}
          {% endif %}
        {% endfor %}
        {{ ns.due }}
```

### 2d. Track what this run requested — `input_text`

Stores the area*id list the current run was \_asked* to clean. Not used for stamping
(stamping is done live per-room, see 3b) but for **skip detection** on dock (3c): any
requested area that wasn't actually cleaned this run gets flagged.

File: `entities/input_text/vacuum_cleaning_areas.yaml`

```yaml
name: Vacuum Cleaning Areas
```

### 2e. Run-start marker — `input_datetime`

Records when the current run started, so the skip-check (3c) can tell which requested
rooms were freshly stamped _during_ this run vs left stale (skipped).

File: `entities/input_datetime/vacuum_run_started.yaml`

```yaml
name: Vacuum Run Started
has_date: true
has_time: true
```

---

## 3. Automations / scripts

### 3a. `script.vacuum_clean_due_rooms` — start a frequency-aware clean

File: add to `scripts/` (vacuum subdir per existing organisation).

```yaml
vacuum_clean_due_rooms:
  alias: "Vacuum: Clean Due Rooms"
  sequence:
    - variables:
        due: "{{ state_attr('sensor.vacuum_rooms_due', 'area_ids') }}"
    - condition: template
      value_template: "{{ due | count > 0 }}"
    - service: input_text.set_value
      target:
        entity_id: input_text.vacuum_cleaning_areas
      data:
        value: "{{ due | to_json }}"
    - service: input_datetime.set_datetime
      target:
        entity_id: input_datetime.vacuum_run_started
      data:
        timestamp: "{{ now().timestamp() }}"
    - service: vacuum.clean_area
      target:
        entity_id: vacuum.dreamevac
      data:
        cleaning_area_id: "{{ due }}"
```

### 3b. `automation` — record last-cleaned live, per room (as the robot cleans)

> **Vacuum-specific** (uses Dreame `current_segment` / `active_segments` / `rooms`). The
> cleaning action stays generic; only this observability layer is Dreame-aware.

Rather than stamping everything on dock, stamp each room the moment the robot is actually
cleaning it. A room the robot never enters (e.g. door closed) never becomes
`current_segment`, so it's correctly left un-stamped.

File: `automations/vacuum/record_last_cleaned.yaml` (replaces `last_run.yaml.disabled`).

- **Trigger:** `vacuum.dreamevac` `current_segment` attribute changes.
- **Conditions:** state is `cleaning`; `current_segment` is not none; `current_segment` is
  in `active_segments` (guards against stale values when docked/idle).
- **Action:** resolve `current_segment` (id) → room name via the live `rooms` attribute,
  match it to the config row by area name, and stamp that `input_datetime` to `now()`.

```yaml
trigger:
  - platform: state
    entity_id: vacuum.dreamevac
    attribute: current_segment
condition:
  - condition: state
    entity_id: vacuum.dreamevac
    state: cleaning
  - condition: template
    value_template: >
      {% set seg = state_attr('vacuum.dreamevac', 'current_segment') %}
      {% set active = state_attr('vacuum.dreamevac', 'active_segments') or [] %}
      {{ seg is not none and seg in active }}
action:
  - variables:
      seg: "{{ state_attr('vacuum.dreamevac', 'current_segment') }}"
      room_name: >
        {% set rooms = state_attr('vacuum.dreamevac', 'rooms')[state_attr('vacuum.dreamevac', 'selected_map')] %}
        {{ rooms | selectattr('id', 'eq', seg) | map(attribute='name') | first }}
      target_dt: >
        {{ state_attr('sensor.vacuum_rooms', 'rooms')
           | selectattr('area', 'eq', room_name)
           | map(attribute='last_cleaned') | first }}
  - condition: template
    value_template: "{{ target_dt is not none }}"
  - service: input_datetime.set_datetime
    target:
      entity_id: "{{ target_dt }}"
    data:
      timestamp: "{{ now().timestamp() }}"
```

> Trade-off: this marks a room cleaned as it _starts_ cleaning it. If a run is aborted
> mid-room, that room is still marked. Acceptable since the main skip cause (closed door)
> means the robot never enters → never becomes `current_segment`. To be stricter, stamp
> `trigger.from_state`'s segment ("just finished") instead, handling the final room on dock.

### 3c. `automation` — notify on skipped rooms (on dock)

When the robot docks, any room that was _requested_ this run but whose `last_cleaned` is
still older than the run-start (3b never stamped it) was skipped → send a heads-up.

File: `automations/vacuum/skipped_rooms_notify.yaml`.

- **Trigger:** `vacuum.dreamevac` state → `docked` (`for:` ~1 min to avoid bounce).
- **Condition:** `input_text.vacuum_cleaning_areas` is a non-empty list.
- **Action:** build the skipped list (requested areas whose `input_datetime` < run-start),
  notify if any, then clear `input_text.vacuum_cleaning_areas`.

```yaml
action:
  - variables:
      run_start: "{{ states('input_datetime.vacuum_run_started') }}"
      skipped: >
        {% set ns = namespace(skip=[]) %}
        {% for aid in (states('input_text.vacuum_cleaning_areas') | from_json) %}
          {% set name = area_name(aid) %}
          {% set dt = state_attr('sensor.vacuum_rooms', 'rooms')
                      | selectattr('area', 'eq', name)
                      | map(attribute='last_cleaned') | first %}
          {% set lc = states(dt) %}
          {% if lc in ['unknown','unavailable',''] or as_datetime(lc) < as_datetime(run_start) %}
            {% set ns.skip = ns.skip + [name] %}
          {% endif %}
        {% endfor %}
        {{ ns.skip }}
  - if:
      - condition: template
        value_template: "{{ skipped | count > 0 }}"
    then:
      - service: notify.send_message
        data:
          entity_id: notify.telegram_raf
          message: "Vacuum skipped: {{ skipped | join(', ') }} (door closed?)"
  - service: input_text.set_value
    target:
      entity_id: input_text.vacuum_cleaning_areas
    data:
      value: ""
```

### 3d. Schedules

Re-enable/rewrite `home_schedule.yaml` / `away_schedule.yaml` to call
`script.vacuum_clean_due_rooms` instead of `vacuum.start`, so every scheduled run only
cleans overdue rooms. Optionally gate on `input_boolean.at_home`.

---

## 4. Flow

```diagram
input_datetime.* (last cleaned) ─┐
sensor.vacuum_rooms (config:     ├─▶ sensor.vacuum_rooms_due ──▶ script.vacuum_clean_due_rooms
  area name ↔ frequency)         ┘   (overdue → [area_ids])        │  vacuum.clean_area(cleaning_area_id)
                                                                   │  store requested list → input_text
                                                                   │  stamp input_datetime.vacuum_run_started
                                                                   ▼
                                                          vacuum.dreamevac cleans
                          (3b) current_segment changes  ───────────┤  per room actually cleaned:
                          & in active_segments                      │  stamp that input_datetime = now()
                                                                   │ state → docked
                          (3c) requested but not stamped ──────────┤  → notify "skipped: <rooms>"
                          since run_start                           ▼  then clear input_text
```

---

## 5. Alternative approaches considered

- **Dreame `vacuum_clean_segment` + segment IDs** (previous draft): works today but ties
  config to this exact vacuum. Rejected in favour of generic `vacuum.clean_area`.
- **Stamp all requested rooms on dock** (earlier draft) instead of live per-room: simpler
  and fully generic, but can't tell that a room was actually skipped (closed door), so it
  would wrongly mark skipped rooms clean. Rejected — replaced by live per-room stamping
  (3b) + skip notification (3c), at the cost of being Dreame-specific.
- **Stamp the room just _finished_ (`trigger.from_state` segment)** instead of the one
  being entered: stricter against mid-room aborts, but needs special handling for the final
  room on dock. Noted as a tweak under 3b.
- **Single JSON `input_text` for all last-cleaned dates** instead of 8 `input_datetime`s:
  fewer entities, but 255-char limit, no UI picker, harder in conditions. Rejected.
- **Per-room frequency as `input_number` helpers** instead of hardcoded `frequency_days`:
  lets you tune from a dashboard without editing YAML. Easy later upgrade.

---

## 6. Build order

1. Create 8 `input_datetime` helpers (2a) + `input_text.vacuum_cleaning_areas` (2d) +
   `input_datetime.vacuum_run_started` (2e).
2. Create `sensor.vacuum_rooms` (2b) and `sensor.vacuum_rooms_due` (2c); verify the due
   list and that `area_id()` resolves every room name (no `None`s).
3. **Verify `vacuum.clean_area` works** on this vacuum with a single area, and confirm
   `current_segment` / `active_segments` / `rooms` behave as expected during a clean.
4. Add `script.vacuum_clean_due_rooms` (3a), the live record automation (3b), and the
   skipped-rooms notification (3c).
5. Rewrite schedules (3d) to call the script.
6. `ha_check_config`, then dry-run: confirm correct areas are sent, each cleaned room is
   stamped live, and a deliberately closed-door room is reported as skipped.
