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
        { "L3MON4D3/LuaSnip" },     -- Required
        { "j-hui/fidget.nvim" },
        { "onsails/lspkind.nvim" },
        { "simrat39/rust-tools.nvim" },
        { "simrat39/inlay-hints.nvim" },
        { "tamago324/nlsp-settings.nvim" },
        { "b0o/schemastore.nvim" },
    },
    config = function(_, _)
        local ih = require("inlay-hints")
        ih.setup()
        local lsp = require('lsp-zero').preset({
            manage_nvim_cmp = {
                set_sources = 'recommended',
            },
        })

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
        end)
        lsp.set_sign_icons({
            error = "❌",
            warn = "⚠️",
            hint = "💡",
            info = "ℹ️",
        })
        lsp.skip_server_setup({ "rust_analyzer" })
        local lspconfig = require("lspconfig")
        -- (Optional) Configure lua language server for neovim
        lspconfig.lua_ls.setup(lsp.nvim_lua_ls())
        lspconfig.tsserver.setup({
            on_attach = function(c, bufnr)
                ih.on_attach(c, bufnr)
            end,
            settings = {
                javascript = {
                    inlayHints = {
                        includeInlayEnumMemberValueHints = true,
                        includeInlayFunctionLikeReturnTypeHints = true,
                        includeInlayFunctionParameterTypeHints = true,
                        includeInlayParameterNameHints = "all", -- 'none' | 'literals' | 'all';
                        includeInlayParameterNameHintsWhenArgumentMatchesName = true,
                        includeInlayPropertyDeclarationTypeHints = true,
                        includeInlayVariableTypeHints = true,
                    },
                },
                typescript = {
                    inlayHints = {
                        includeInlayEnumMemberValueHints = true,
                        includeInlayFunctionLikeReturnTypeHints = true,
                        includeInlayFunctionParameterTypeHints = true,
                        includeInlayParameterNameHints = "all", -- 'none' | 'literals' | 'all';
                        includeInlayParameterNameHintsWhenArgumentMatchesName = true,
                        includeInlayPropertyDeclarationTypeHints = true,
                        includeInlayVariableTypeHints = true,
                    },
                },
            }
        })
        require("fidget").setup({
            text = {
                spinner = "bouncing_ball",
            },
            window = {
                border = "rounded"
            },
        })
        lsp.setup()
        local rust_tools = require('rust-tools')
        rust_tools.setup({
            tools = {
                inlay_hints = {
                    parameter_hints_prefix = "",
                    other_hints_prefix = "󰞔 ",
                },
            },
        })
        local cmp = require("cmp")
        local cmp_action = require("lsp-zero").cmp_action()
        local lspkind = require("lspkind")
        local cmp_select_opts = {behavior = cmp.SelectBehavior.Select}
        cmp.setup({
            mapping = {
                -- `Enter` key to confirm completion
                ['<CR>'] = cmp.mapping.confirm({ select = false }),
                -- Ctrl+Space to trigger completion menu
                ['<C-Space>'] = cmp.mapping.complete(),
                -- Navigate between snippet placeholder
                ['<C-f>'] = cmp_action.luasnip_jump_forward(),
                ['<C-b>'] = cmp_action.luasnip_jump_backward(),
                ['<Tab>'] = cmp.mapping(function()
                    if cmp.visible() then
                        cmp.select_next_item(cmp_select_opts)
                    else
                        cmp.complete()
                    end
                end),
                ['<S-Tab>'] = cmp.mapping(function()
                    if cmp.visible() then
                        cmp.select_prev_item(cmp_select_opts)
                    else
                        cmp.complete()
                    end
                end)
            },
            window = {
                documentation = cmp.config.window.bordered(),
            },
            formatting = {
                fields = { "menu", "abbr", "kind" },
                format = lspkind.cmp_format({
                    mode = "symbol",       -- show only symbol annotations
                    maxwidth = 50,         -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
                    ellipsis_char = '...', -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)
                    menu = ({
                        buffer = "",
                        nvim_lsp = "λ",
                        luasnip = "⋗",
                        nvim_lua = "󰢱",
                        path = "🖫"
                    }),
                })
            }
        })
        local function extend(tab1, tab2)
          for _, value in ipairs(tab2 or {}) do
            table.insert(tab1, value)
          end
          return tab1
        end
        local nlspsettings = require("nlspsettings")
        local nlsp_schemas = nlspsettings.get_default_schemas()
        local schema_store = require('schemastore').json.schemas()
        local schemas = {}
        schemas = extend(schemas, schema_store)
        schemas = extend(schemas, nlsp_schemas)
        nlspsettings.setup({
          local_settings_dir = ".vim",
          local_settings_root_markers_fallback = { '.git' },
          loader = "json",
        })
        lspconfig.jsonls.setup({
            settings = {
                json = {
                    schemas = schemas,
                    validate = { enable = true },
                },
            },
        })
    end
}
