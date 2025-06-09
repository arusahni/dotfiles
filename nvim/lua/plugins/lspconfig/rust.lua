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
                    -- checkOnSave = {
                    --     command = "clippy",
                    -- },
                    cargo = {
                        features = "all",
                    },
                    rust = {
                        analyzerTargetDir = "target-ra"
                    }
                },
            },
        },
        tools = {
            enable_clippy = false,
        },
    }
end

return M
