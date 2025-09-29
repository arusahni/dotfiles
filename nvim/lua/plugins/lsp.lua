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

return {

    {
        "hrsh7th/nvim-cmp",
        event = "InsertEnter",
        dependencies = {
            { "L3MON4D3/LuaSnip",        version = "v2.*" },
            { "saadparwaiz1/cmp_luasnip" },
            { "onsails/lspkind.nvim" },
            { "hrsh7th/cmp-buffer" },
        },
        config = function()
            -- Autocompletion
            require("plugins.lspconfig.cmp").setup()
            require("luasnip.loaders.from_snipmate").lazy_load({ paths = "~/.config/nvim/snippets" })
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
            -- {
            --     "mason-org/mason.nvim",
            --     -- build = function()
            --     --     pcall(vim.cmd, "MasonUpdate")
            --     -- end,
            -- },
            {
                "mason-org/mason-lspconfig.nvim",
                dependencies = {
                    { "mason-org/mason.nvim" },
                }
            },
            { "nvimtools/none-ls.nvim" },

            -- LSP customizations
            { "j-hui/fidget.nvim",                tag = "v1.4.5" },
            { "MysticalDevil/inlay-hints.nvim" },
            { "tamago324/nlsp-settings.nvim" },

            -- Language customizations
            -- { "simrat39/rust-tools.nvim" },
            {
                "mrcjkb/rustaceanvim",
                version = '^4', -- Recommended
                lazy = false,   -- This plugin is already lazy
            },
            { "b0o/schemastore.nvim" },
            { "aznhe21/actions-preview.nvim" },
        },
        config = function(_, _)
            -- Comment this out for debugging
            vim.lsp.set_log_level("off")
            local inlay = require("plugins.lspconfig.inlay").setup()
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
                    "ruff",
                    "svelte",
                    "yamlls",
                    "jsonls",
                    exclude = {
                        "rust_analyzer"
                    }
                }
            })
            require("plugins.lspconfig.fidget")
            require("plugins.lspconfig.lua").setup()
            require("plugins.lspconfig.typescript").setup({ inlay = inlay })
            require("plugins.lspconfig.rust").setup({ inlay = inlay })
            require("plugins.lspconfig.json").setup()
            require("plugins.lspconfig.null").setup()
            local nlspsettings = require("nlspsettings")
            nlspsettings.setup({
                local_settings_dir = ".vim",
                local_settings_root_markers_fallback = { ".git" },
                -- Schemas are extended in plugins.lspconfig.json
                append_default_schemas = true,
                loader = "json",
            })
            -- Todo: configure LSP zero
            vim.api.nvim_create_autocmd("LspAttach", {
                desc = "LSP document highlighting",
                callback = function(event)
                    local client = vim.lsp.get_client_by_id(event.data.client_id)
                    if not client then
                        return
                    end
                    local bufnr = event.buf
                    lsp_attach(client, bufnr)
                end
            });
        end
    },
    {
        "rachartier/tiny-inline-diagnostic.nvim",
        event = "VeryLazy",
        priority = 1000, -- needs to be loaded in first
        opts = {
            preset = "powerline",
            options = {
                show_source = true,
            }
        }
    },

    {
        "hedyhli/outline.nvim",
        lazy = true,
        cmd = { "Outline", "OutlineOpen" },
        keys = { "<leader>o", "<cmd>Outline<CR>", desc = "Toggle outline" },
        opts = {}
    },

}
