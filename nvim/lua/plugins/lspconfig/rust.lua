local M = {}

function M.setup(settings)
    settings["lsp"].skip_server_setup({ "rust_analyzer" })
    local rust_tools = require('rust-tools')
    rust_tools.setup({
        tools = {
            inlay_hints = {
                parameter_hints_prefix = "",
                other_hints_prefix = "󰞔 ",
                highlight = "CocInlayHint",
            },
        },
    })
end

return M
