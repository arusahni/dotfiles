local M = {}

function M.setup()
    local lsp_zero = require("lsp-zero")
    lsp_zero.extend_lspconfig({
        capabilities = require("cmp_nvim_lsp").default_capabilities(),
        lsp_attach = lsp_attach,
    })
    return lsp_zero
end

return M
