return {

    {
        "VonHeikemen/lsp-zero.nvim",
        branch = "v4.x",
        lazy = true,
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
            require("plugins.lspconfig.cmp").setup()
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
            local inlay = require("plugins.lspconfig.inlay").setup()
            local lsp = require("plugins.lspconfig.lsp-zero").setup()
            require("mason").setup({})
            require("mason-lspconfig").setup({
              ensure_installed = {
                "ts_ls",
                "lua_ls",
                "pyright",
                "bashls",
                "docker_compose_language_service",
                "dockerls",
                "eslint",
                "html",
                "marksman",
                "ruff_lsp",
                "svelte",
                "yamlls",
                "jsonls",
              }
            })
            require("mason-lspconfig").setup_handlers({
                function(server_name)
                    -- Autoconfigure the LSP for installed Mason servers
                    require("lspconfig")[server_name].setup({})
                end,
                -- Force no-op for r-a so Meson can't install it
                rust_analyzer = function()
                  return true
                end,
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
