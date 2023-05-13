local M = {}
local cmp = require("cmp")
local cmp_api = require("cmp.utils.api")

-- Handle the various cases where a tab character may be used
local function tab_completion(select_item_action)
    local cmp_select_opts = { behavior = cmp.SelectBehavior.Select }
    return function(fallback)
        -- tabs should only pass through when there's no text preceding the cursor
        local _, col = unpack(vim.api.nvim_win_get_cursor(0))
        local line_prefix = string.sub(vim.api.nvim_get_current_line(), 1, col)
        local all_whitespace = line_prefix:match("^%s*$") ~= nil
        if cmp.visible() then
            -- We're selecting a menu item
            select_item_action(cmp_select_opts)
        elseif cmp_api.is_insert_mode() and all_whitespace then
            -- We're not actively completing, pass through
            fallback()
        else
            -- We're completing a word, load the completions
            cmp.complete()
        end
    end
end

function M.setup(settings)
    local cmp_action = settings["cmp_action"]
    local lspkind = require("lspkind")
    cmp.setup({
        mapping = {
            -- `Enter` key to confirm completion
            ['<CR>'] = cmp.mapping.confirm({ select = false }),
            -- Ctrl+Space to trigger completion menu
            ['<C-Space>'] = cmp.mapping.complete(),
            -- Navigate between snippet placeholder
            ['<C-f>'] = cmp_action.luasnip_jump_forward(),
            ['<C-b>'] = cmp_action.luasnip_jump_backward(),
            ['<Tab>'] = cmp.mapping(tab_completion(cmp.select_next_item)),
            ['<S-Tab>'] = cmp.mapping(tab_completion(cmp.select_prev_item)),
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
        },
        sources = {
            { name = 'path' },
            { name = "nvim_lsp" },
            { name = "nvim_lsp_signature_help" },
            { name = 'buffer', keyword_length = 3 },
            { name = 'luasnip', keyword_length = 2 },
        }
    })
end

return M
