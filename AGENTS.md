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

A live MCP connection to the HA instance is available via `ha_*` tool calls.

- **Start with best practices:** Always start with calling `ha_get_skill_home_assistant_best_practices` then `read_resource(uri)` on the returned files for automation patterns, dashboard guides, helper selection, etc.
- **System overview:** `ha_get_overview()` for system summary; `ha_search_entities(query)` to find entity IDs.
- **Read state:** `ha_get_state(entity_id)` / `ha_get_states([...])` for current values; `ha_get_history()` for past.
- **Config (check):** `ha_check_config` to check the configuration for errors.
- **Config (read):** `ha_config_get_automation(id)`, `ha_config_get_script(id)`, `ha_config_get_dashboard()`.
- **Config (write):** `ha_config_set_automation(config)`, `ha_config_set_script(id, config)`, `ha_config_set_dashboard(url_path, ...)`.
- **Search configs:** `ha_deep_search(query)` searches inside automation/script/helper definitions.
- **Full tool docs:** https://homeassistant-ai.github.io/ha-mcp/tools/

Always use Context7 when I need library/API documentation, code generation, setup or configuration steps without me having to explicitly ask, using /home-assistant/home-assistant.io.

## Rules

- Follow existing patterns and styles for defining new configurations (such as automations, scripts), in naming, organisation and structure.
- Never modify anything that is not part of the core HA configuration or is third party code (such as `custom_components/`), this generally includes all files ignored by version control.
- Edit yaml files directly to read and write configurations, but use the MCP tools to find information about HA, such as entity IDs and to validate configurations.
- Always ask for confirmation before calling destructive or reload‑style tools or calling services or changing entity states that will immediately affect HA.
- Prefer standard HA automation / condition / service configuration over templates where it is possible.

## Lint / Validate

- **Yaml lint:** `yamllint .` (config in `.yamllint`)
- **Prettier:** `prettier --write "**/*.{md,yml,yaml}"` (config in `.prettierrc.yaml`)
- **Config / Validation:** use MCP tools listed below
