local M = {}
function M.setup()
    local lspzero = require('lsp-zero')
    return {
        lsp = lspzero.preset({}),
        cmp_action = lspzero.cmp_action(),
    }
end

return M
