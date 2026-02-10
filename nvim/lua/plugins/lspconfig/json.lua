local M = {}

local function extend(tab1, tab2)
  for _, value in ipairs(tab2 or {}) do
    table.insert(tab1, value)
  end
  return tab1
end

function M.setup()
    -- local lspconfig = require("lspconfig")
    local nlspsettings = require("nlspsettings")
    local nlsp_schemas = nlspsettings.get_default_schemas()
    local schema_store = require('schemastore').json.schemas()

    local schemas = {}
    schemas = extend(schemas, schema_store)
    schemas = extend(schemas, nlsp_schemas)
    local global_capabilities = vim.lsp.protocol.make_client_capabilities()
    global_capabilities.textDocument.completion.completionItem.snippetSupport = true
    vim.lsp.config("jsonls", {
        capabilities = global_capabilities,
        settings = {
            json = {
                schemas = schemas,
                validate = { enable = true },
            },
        },
    })
end

return M
