local M = {}

function M.setup(settings)
    local null_ls = require("null-ls")

    null_ls.setup({
        sources = {
            null_ls.builtins.formatting.black,
            null_ls.builtins.formatting.prettier,
        },
    })
end

return M
