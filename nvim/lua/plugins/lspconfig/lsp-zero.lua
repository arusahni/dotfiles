local M = {}
function M.setup()
    local lspzero = require('lsp-zero')
    return {
        lsp = lspzero.preset({
            manage_nvim_cmp = {
                set_sources = 'recommended',
            },
        }),
        cmp_action = lspzero.cmp_action(),
    }
end

return M
