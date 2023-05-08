local M = {}

local function extend(tab1, tab2)
  for _, value in ipairs(tab2 or {}) do
    table.insert(tab1, value)
  end
  return tab1
end

function M.setup()
    local lspconfig = require("lspconfig")
    local nlspsettings = require("nlspsettings")
    local nlsp_schemas = nlspsettings.get_default_schemas()
    local schema_store = require('schemastore').json.schemas()

    local schemas = {}
    schemas = extend(schemas, schema_store)
    schemas = extend(schemas, nlsp_schemas)
    nlspsettings.setup({
      local_settings_dir = ".vim",
      local_settings_root_markers_fallback = { '.git' },
      loader = "json",
    })
    lspconfig.jsonls.setup({
        settings = {
            json = {
                schemas = schemas,
                validate = { enable = true },
            },
        },
    })
end

return M
