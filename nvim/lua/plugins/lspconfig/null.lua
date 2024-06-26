local M = {}

function M.setup(settings)
    local null_ls = require("null-ls")

    null_ls.setup({
        debug = false,
        sources = {
            null_ls.builtins.formatting.black.with({ prefer_local = true }),
            null_ls.builtins.formatting.prettier.with({ prefer_local = "node_modules/.bin" }),
        },
    })
end

return M
