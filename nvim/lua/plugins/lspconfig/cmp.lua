local M = {}
local cmp = require("cmp")
local cmp_api = require("cmp.utils.api")
local feedkeys = require('cmp.utils.feedkeys')
local keymap = require('cmp.utils.keymap')

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

local function confirm_completion(fallback)
    -- from cmp https://github.com/hrsh7th/nvim-cmp/issues/1326
    if vim.fn.pumvisible() == 1 then
        -- native pumenu
        -- workaround for neovim/neovim#22892
        if vim.fn.complete_info({ "selected" }).selected == -1 then
            -- nothing selected, insert newline
            feedkeys.call(keymap.t("<CR>"), "in")
        else
            -- something selected, confirm selection by stopping Ctrl-X mode
            -- :h i_CTRL-X_CTRL-Z*
            feedkeys.call(keymap.t("<C-X><C-Z>"), "in")
        end
    else
        -- `nvim-cmp` default confirm action
        -- Accept currently selected item.
        -- Set `select` to `false` to only confirm explicitly selected items.
        cmp.mapping.confirm({ select = false })(fallback)
    end
end

function M.setup(settings)
    local cmp_action = settings["cmp_action"]
    local lspkind = require("lspkind")
    cmp.setup({
        mapping = {
            -- `Enter` key to confirm completion
            ['<CR>'] = confirm_completion,
            -- Ctrl+Space to trigger completion menu
            ['<C-Space>'] = cmp.mapping.complete(),
            -- Navigate between snippet placeholder
            ['<C-b>'] = cmp.mapping.scroll_docs(-4),
            ['<C-f>'] = cmp.mapping.scroll_docs(4),
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
            { name = "path" },
            { name = "nvim_lsp" },
            { name = "nvim_lsp_signature_help" },
            { name = "buffer" },
            { name = "luasnip", keyword_length = 2 },
        }
    })
end

return M
