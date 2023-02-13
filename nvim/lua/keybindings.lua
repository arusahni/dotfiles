U = require('utils')
local telescope = require('telescope.builtin')

function map(mode, lhs, rhs, opts)
    local options = { }
    if opts then
        options = vim.tbl_extend("force", options, opts)
    end
    vim.keymap.set(mode, lhs, rhs, options)
end

function show_documentation()
    if vim.bo.filetype == 'vim' then
        vim.api.nvim_command([['h '.expand('<cword>')]])
    else
        vim.api.nvim_command([[:call CocActionAsync('doHover')]])
    end
end

function check_back_space()
    local col = vim.api.nvim_win_get_cursor(0)[2]
    return (col == 0 or vim.api.nvim_get_current_line():sub(col, col):match("%s")) and true
end

map("i", "jj", "<Esc>")
map("n", "<leader>nt", ":NvimTreeToggle<CR>")
map("n", "<leader>nq", ":NvimTreeClose<CR>")
map("n", "<C-p>", telescope.find_files)
map("", "<leader>n", ":bn<CR>")
map("", "<leader>p", ":bp<CR>")
map("n", "<leader>/", ":nohl<CR>", { silent = true })
map("t", "<ESC>", "<C-\\><C-n>")
map("i", "<C-SPACE>", "coc#refresh()", { expr = true, silent = true })
vim.cmd([[
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1):
      \ v:lua.check_back_space() ? "\<TAB>" :
      \ coc#refresh()
]])
map("i", "<S-TAB>", 'coc#pum#visible() ? "coc#pum#prev(1)" : "<C-h>"', { expr = true })
map("i", "<CR>", 'coc#pum#visible() ? coc#pum#confirm() : "<C-g>u<CR><C-r>=coc#on_enter()<CR>"', { expr = true })
map("n", "gd", "<Plug>(coc-definition)", { silent = true})
map("n", "gy", "<Plug>(coc-type-definition)", { silent = true})
map("n", "gr", "<Plug>(coc-references)", { silent = true})
map("n", "[g", "<Plug>(coc-diagnostic-prev)", { silent = true})
map("n", "]g", "<Plug>(coc-diagnostic-next)", { silent = true})
map("x", "<leader>f", "<Plug>(coc-format-selected)")
map("n", "<leader>f", "<Plug>(coc-format-selected)")
map("n", "K", show_documentation, { silent = true })
map("", "<C-/><C-/>", "<C-_><C-_>", { remap = true })
map("", "<C-_><C-_>", "gcc", { remap = true })
map("v", "<C-_><C-_>", "gc", { remap = true })
map("n", "<leader>t", ":TestNearest<CR>", { silent = true })
map("n", "<leader>T", ":TestFile<CR>", { silent = true })
map("n", "<leader>a", ":TestSuite<CR>", { silent = true })
map("n", "<leader>l", ":TestLast<CR>", { silent = true })
map("n", "<leader>g", ":TestVisit<CR>", { silent = true })
map("n", "<C-Space>", telescope.buffers)
if U.is_linux() then
    map("n", "gx", "<Cmd>call jobstart(['xdg-open', expand('<cfile>')])<CR>")
elseif U.is_mac() then
    map("n", "gx", "<Cmd>call jobstart(['open', expand('<cfile>')])<CR>")
end
map("n", "<leader>qt", ":Tclose!<CR>", { silent = true })

--  Start interactive EasyAlign in visual mode (e.g. vip<Enter>)
map("v", "<Enter>", "<Plug>(EasyAlign)", { remap = true })
-- Start interactive EasyAlign for a motion/text object (e.g. gaip)
map("n", "ga", "<Plug>(EasyAlign)", { remap = true })
