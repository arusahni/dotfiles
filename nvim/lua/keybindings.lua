U = require('utils')
local telescope = require('telescope.builtin')

local function map(mode, lhs, rhs, opts)
    local options = {}
    if opts then
        options = vim.tbl_extend("force", options, opts)
    end
    vim.keymap.set(mode, lhs, rhs, options)
end

map("i", "jj", "<Esc>")
map("n", "<leader>nt", ":NvimTreeToggle<CR>")
map("n", "<leader>nq", ":NvimTreeClose<CR>")
map("n", "<C-p>", telescope.find_files)
map("n", "<leader>rg", telescope.live_grep)
map("", "<leader>n", ":bn<CR>")
map("", "<leader>p", ":bp<CR>")
map("n", "<leader>/", ":nohl<CR>", { silent = true })
map("t", "<ESC>", "<C-\\><C-n>")
map("n", "[g", vim.diagnostic.goto_prev, { silent = true })
map("n", "]g", vim.diagnostic.goto_next, { silent = true })
map("n", "[e", function() vim.diagnostic.goto_prev({ severity = vim.diagnostic.severity.ERROR }) end, { silent = true })
map("n", "]e", function() vim.diagnostic.goto_next({ severity = vim.diagnostic.severity.ERROR }) end, { silent = true })
map("", "<C-/><C-/>", "<C-_><C-_>", { remap = true })
map("", "<C-_><C-_>", "gcc", { remap = true })
map("v", "<C-_><C-_>", "gc", { remap = true })
map("n", "<leader>t", ":TestNearest<CR>", { silent = true })
map("n", "<leader>T", ":TestFile<CR>", { silent = true })
map("n", "<leader>A", ":TestSuite<CR>", { silent = true })
map("n", "<leader>l", ":TestLast<CR>", { silent = true })
map("n", "<leader>g", ":TestVisit<CR>", { silent = true })
map("n", "<C-Space>", telescope.buffers)

vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('UserLspConfig', {}),
    callback = function(ev)
        local opts = { buffer = ev.buf }
        map({ "v", "n" }, "<leader>a", require("actions-preview").code_actions, opts)
        map("n", "gd", telescope.lsp_definitions, opts)
        map("n", "gy", telescope.lsp_type_definitions, opts)
        map("n", "gr", telescope.lsp_references, opts)
        map({ "n", "x" }, "<leader>f", function() vim.lsp.buf.format({ async = false, timeout_ms = 10000 }) end, opts)
        map({ "n", "x" }, "gq", function() vim.lsp.buf.format({ async = false, timeout_ms = 10000 }) end, opts)
        map("n", "K", vim.lsp.buf.hover, opts)
        map("i", "<C-k>", vim.lsp.buf.signature_help, opts)
        map("n", "<leader>r", vim.lsp.buf.rename, opts)
    end
})

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
