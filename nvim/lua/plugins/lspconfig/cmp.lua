local M = {}
local cmp = require("cmp")
local cmp_api = require("cmp.utils.api")
local feedkeys = require('cmp.utils.feedkeys')
local keymap = require('cmp.utils.keymap')
local luasnip = require("luasnip")

local has_words_before = function()
  unpack = unpack or table.unpack
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

-- Handle the various cases where a tab key may be used
local function tab_completion_next(fallback)
    local cmp_select_opts = { behavior = cmp.SelectBehavior.Select }
    -- tabs should only pass through when there's no text preceding the cursor
    if cmp.visible() then
        -- We're selecting a menu item
        cmp.select_next_item(cmp_select_opts)
    elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
    elseif has_words_before() then
        -- We're completing a word, load the completions
        cmp.complete()
    else
        fallback()
    end
end

-- Handle the various cases where a shift-tab key may be used
local function tab_completion_prev(fallback)
    local cmp_select_opts = { behavior = cmp.SelectBehavior.Select }
    -- tabs should only pass through when there's no text preceding the cursor
    if cmp.visible() then
        -- We're selecting a menu item
        cmp.select_prev_item(cmp_select_opts)
    elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
    else
        fallback()
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

function M.setup()
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
            ['<Tab>'] = cmp.mapping(tab_completion_next, { "i", "s" }),
            ['<S-Tab>'] = cmp.mapping(tab_completion_prev, { "i", "s" }),
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
        snippet = {
            expand = function(args)
                require("luasnip").lsp_expand(args.body)
            end,
        },
        sources = {
            { name = "nvim_lsp" },
            { name = "nvim_lsp_signature_help" },
            { name = "luasnip", keyword_length = 2 },
            { name = "path" },
            { name = "buffer", keyword_length = 5 },
        }
    })
end

return M
