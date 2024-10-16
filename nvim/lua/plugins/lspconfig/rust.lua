local M = {}

function M.setup(settings)
    vim.g.rustaceanvim = {
        server = {
            on_attach = function(client, bufnr)
                settings["inlay"].on_attach(client, bufnr)
                -- Disable LSP syntax highlighting
                client.server_capabilities.semanticTokensProvider = nil
            end,
            default_settings = {
                ["rust-analyzer"] = {
                    checkOnSave = {
                        command = "clippy",
                    },
                    rust = {
                        analyzerTargetDir = "target-ra"
                    }
                },
            },
        }
    }
end

return M
