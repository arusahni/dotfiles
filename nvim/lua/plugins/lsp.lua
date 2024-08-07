return {

    {
        "VonHeikemen/lsp-zero.nvim",
        branch = "v2.x",
        lazy = true,
        config = function()
            require("lsp-zero.settings").preset({})
        end
    },
    {
        "hrsh7th/nvim-cmp",
        event = "InsertEnter",
        dependencies = {
            { "L3MON4D3/LuaSnip", version = "v2.*" },
            { "saadparwaiz1/cmp_luasnip" },
            { "onsails/lspkind.nvim" },
            { "hrsh7th/cmp-buffer" },
        },
        config = function()
            -- Autocompletion
            local lspzero = require("plugins.lspconfig.lsp-zero").setup()
            local lsp = lspzero["lsp"]
            local cmp_action = lspzero["cmp_action"]
            require("plugins.lspconfig.cmp").setup({ cmp_action = cmp_action })
            require("luasnip.loaders.from_snipmate").lazy_load({paths = "~/.config/nvim/snippets"})
        end
    },
    {
        "neovim/nvim-lspconfig",
        cmd = { "LspInfo" },
        event = { "BufReadPre", "BufNewFile" },
        dependencies = {
            -- LSP Support
            { "hrsh7th/cmp-nvim-lsp" },
            { "hrsh7th/cmp-nvim-lsp-signature-help" },
            {
                "williamboman/mason.nvim",
                build = function()
                    pcall(vim.cmd, "MasonUpdate")
                end,
            },
            { "williamboman/mason-lspconfig.nvim" },
            { "nvimtools/none-ls.nvim" },

            -- LSP customizations
            { "j-hui/fidget.nvim",                tag = "v1.4.5" },
            { "simrat39/inlay-hints.nvim" },
            { "tamago324/nlsp-settings.nvim" },

            -- Language customizations
            -- { "simrat39/rust-tools.nvim" },
            {
                "mrcjkb/rustaceanvim",
                version = '^4', -- Recommended
                lazy = false, -- This plugin is already lazy
            },
            { "b0o/schemastore.nvim" },
            { "aznhe21/actions-preview.nvim" },
        },
        config = function(_, _)
            -- Comment this out for debugging
            vim.lsp.set_log_level("off")
            local lspzero = require("plugins.lspconfig.lsp-zero").setup()
            local lsp = lspzero["lsp"]
            require("mason-lspconfig").setup_handlers({
                -- Force no-op for r-a so Meson can't install it
                rust_analyzer = function()
                  return true
                end,
            })
            lsp.ensure_installed({
                "tsserver",
                "lua_ls",
                "pyright",
                "bashls",
                "docker_compose_language_service",
                "dockerls",
                "eslint",
                "html",
                "marksman",
                "ruff_lsp",
                -- "rust_analyzer",
                "svelte",
                "yamlls",
                "jsonls",
            })
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
                error = "",
                warn = "",
                hint = "",
                info = "",
            })
            require("plugins.lspconfig.fidget")
            require("plugins.lspconfig.lua").setup({ lsp = lsp })
            require("plugins.lspconfig.typescript").setup({ inlay = inlay })
            require("plugins.lspconfig.rust").setup({ inlay = inlay, lsp = lsp })
            require("plugins.lspconfig.json").setup()
            require("plugins.lspconfig.null").setup()
            lsp.setup()
            local nlspsettings = require("nlspsettings")
            nlspsettings.setup({
                local_settings_dir = ".vim",
                local_settings_root_markers_fallback = { ".git" },
                -- Schemas are extended in plugins.lspconfig.json
                append_default_schemas = true,
                loader = "json",
            })
        end
    }
}
