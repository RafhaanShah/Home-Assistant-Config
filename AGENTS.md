# AGENTS.md — Home Assistant Configuration

## Architecture

- Pure YAML config repo for a Home Assistant (HA) instance (no application code).
- `configuration.yaml` — root config; loads packages via `!include_dir_named integrations`.
- `integrations/` — one YAML per HA integration (packages pattern). Disable by appending `.disabled`.
- `automations/` — automations organized by domain subdirectories (alarm, light, media, etc.).
- `entities/` — entity definitions grouped by platform (sensor, input_boolean, template, etc.).
- `scripts/` — HA script definitions, organized by domain subdirectories.
- `scenes/`, `customizations/`, `services/` — scenes, entity customizations, and service calls.
- `custom_components/` — third-party HACS integrations (excluded from lint/CI).
- `esphome/`, `zigbee2mqtt/`, `node-red/` — configs for companion services.
- `secrets_example.yaml` — contains example secrets values.

## MCP Tools and Skills

Use `ha_*` tool calls for the live HA MCP tools, and always `context7` for in-depth documentation, without me having to explicitly ask.

- **Home Assistant Documentation:** use `context7` for documentation and code examples, using library `/home-assistant/home-assistant.io`.
- **ESPHome Documentation:** use `context7` for ESPHome configuration and documentation, using library `/websites/esphome_io`.
- **Best practices:** before making a configuration change, always call `ha_get_skill_guide` tool, with no arguments first to list available skills, then call it with the specific `skill` and `file` parameters to read the relevant guides.
- **Search tools:** use `ha_search_tools` to search for all available tools to use.
- **System overview:** `ha_get_overview` for system summary; `ha_search_entities(query)` to find entity IDs.
- **Read state:** `ha_get_state` / `ha_get_states` for current values; `ha_get_history` for past.
- **Config (check):** `ha_check_config` to check the configuration for errors after making config changes.
- **Search configs:** `ha_search` searches for entities, domains, areas and inside automation/script/helper definitions.
- **Evaluate templates:** use `ha_eval_template` to evaluate Jinja2 templates using Home Assistant's template engine.

## Rules

- Follow existing patterns and styles for defining new configurations (such as automations, scripts), in naming, organisation and structure.
- Never modify anything that is not part of the core HA configuration or is third party code (such as `custom_components/`), this generally includes all files ignored by version control.
- Edit yaml files directly to read and write configurations, but use the MCP tools to find information about HA, such as entity IDs and to validate configurations.
- You must ask for confirmation before calling destructive or reload‑style tools, or calling any services or actions, or changing entity states that will immediately affect HA.
- Always use and prefer standard HA automation / condition / action configuration in yaml over generic Jinja2/templates.

## Lint / Validate

- **Yaml lint:** `yamllint .` (config in `.yamllint`)
- **Prettier:** `prettier --write "**/*.{md,yml,yaml}"` (config in `.prettierrc.yaml`)
- **Config / Validation:** use MCP tools listed
