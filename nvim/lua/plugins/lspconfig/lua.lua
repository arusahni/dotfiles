local M = {}

function M.setup(settings)
    local lspconfig = require("lspconfig")
    -- (Optional) Configure lua language server for neovim
    lspconfig.lua_ls.setup(settings["lsp"].nvim_lua_ls())
end

return M
