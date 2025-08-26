local M = {}
local function lsp_attach(client, bufnr)
    if client.supports_method "textDocument/documentHighlight" then
        local group = vim.api.nvim_create_augroup("lsp_document_highlight", { clear = true })
        vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
            group = group,
            buffer = bufnr,
            callback = vim.lsp.buf.document_highlight,
        })
        vim.api.nvim_create_autocmd("CursorMoved", {
            group = group,
            buffer = bufnr,
            callback = vim.lsp.buf.clear_references,
        })
    end
    vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(
        vim.lsp.handlers['signature_help'],
        { border = 'single', close_events = { "CursorMoved", "BufHidden", "InsertCharPre" } }
    )
end

function M.setup()
    local lsp_zero = require("lsp-zero")
    lsp_zero.extend_lspconfig({
        capabilities = require("cmp_nvim_lsp").default_capabilities(),
        lsp_attach = lsp_attach,
    })
    return lsp_zero
end

return M
