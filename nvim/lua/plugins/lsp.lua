return {
    "VonHeikemen/lsp-zero.nvim",
    branch = 'v2.x',
    dependencies = {
        -- LSP Support
        { "neovim/nvim-lspconfig" }, -- Required
        {
            -- Optional
            "williamboman/mason.nvim",
            build = function()
                pcall(vim.cmd, "MasonUpdate")
            end,
        },
        { "williamboman/mason-lspconfig.nvim" }, -- Optional

        -- Autocompletion
        { "hrsh7th/nvim-cmp" },     -- Required
        { "hrsh7th/cmp-nvim-lsp" }, -- Required
        { "hrsh7th/cmp-nvim-lsp-signature-help" },
        { "L3MON4D3/LuaSnip" },     -- Required
        { "j-hui/fidget.nvim" },
        { "onsails/lspkind.nvim" },
        { "simrat39/rust-tools.nvim" },
        { "simrat39/inlay-hints.nvim" },
        { "tamago324/nlsp-settings.nvim" },
        { "b0o/schemastore.nvim" },
    },
    config = function(_, _)
        local lspzero = require("plugins.lspconfig.lsp-zero").setup()
        local lsp = lspzero["lsp"]
        local cmp_action = lspzero["cmp_action"]
        local inlay = require("plugins.lspconfig.inlay").setup()
        lsp.on_attach(function(client, bufnr)
            lsp.default_keymaps({
                buffer = bufnr,
                preserve_mappings = false,
            })
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
        end)
        lsp.set_sign_icons({
            error = "❌",
            warn = "⚠️",
            hint = "💡",
            info = "ℹ️",
        })
        require("plugins.lspconfig.fidget")
        require("plugins.lspconfig.lua").setup({ lsp = lsp })
        require("plugins.lspconfig.typescript").setup({ inlay = inlay })
        require("plugins.lspconfig.rust").setup({ inlay = inlay, lsp = lsp })
        require("plugins.lspconfig.json").setup()
        lsp.setup()
        require("plugins.lspconfig.cmp").setup({ cmp_action = cmp_action })
    end
}
