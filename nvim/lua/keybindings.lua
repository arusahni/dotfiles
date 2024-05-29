U = require('utils')
local telescope = require("telescope")
local telescope_builtin = require("telescope.builtin")
local telescope_conf = require("telescope.config").values
local lga_shortcuts = require("telescope-live-grep-args.shortcuts")
local neotest = require("neotest")
local harpoon = require("harpoon")

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
map("n", "<C-p>", telescope_builtin.find_files)
map("n", "<leader>rg", telescope.extensions.live_grep_args.live_grep_args)
map("n", "<C-8>", lga_shortcuts.grep_word_under_cursor)
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
map("n", "<leader>t", function()
    neotest.summary.open()
    neotest.run.run()
end, { silent = true })
map("n", "<leader>st", neotest.run.stop, { silent = true })
map("n", "<leader>T", function() neotest.run.run(vim.fn.expand("%")) end, { silent = true })
map("n", "<leader>A", function()
    neotest.summary.open()
    neotest.run.run(vim.fn.getcwd())
end, { silent = true })
map("n", "<leader>l", neotest.run.run_last, { silent = true })
-- map("n", "<C-Space>", telescope_builtin.buffers)

vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('UserLspConfig', {}),
    callback = function(ev)
        local opts = { buffer = ev.buf }
        map({ "v", "n" }, "<leader>a", require("actions-preview").code_actions, opts)
        map("n", "gd", telescope_builtin.lsp_definitions, opts)
        map("n", "gy", telescope_builtin.lsp_type_definitions, opts)
        map("n", "gr", telescope_builtin.lsp_references, opts)
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
map("n", "<leader>qt", neotest.summary.close, { silent = true })

--  Start interactive EasyAlign in visual mode (e.g. vip<Enter>)
map("v", "<Enter>", "<Plug>(EasyAlign)", { remap = true })
-- Start interactive EasyAlign for a motion/text object (e.g. gaip)
map("n", "ga", "<Plug>(EasyAlign)", { remap = true })


-- Harpoon
local function toggle_telescope(harpoon_files)
    local file_paths = {}
    for _, item in ipairs(harpoon_files.items) do
        table.insert(file_paths, item.value)
    end

    require("telescope.pickers").new({}, {
        prompt_title = "Harpoon",
        finder = require("telescope.finders").new_table({
            results = file_paths,
        }),
        previewer = telescope_conf.file_previewer({}),
        sorter = telescope_conf.generic_sorter({}),
    }):find()
end

vim.keymap.set("n", "<leader>h", function() harpoon:list():add() end)
vim.keymap.set("n", "<C-Space>", function() toggle_telescope(harpoon:list()) end,
    { desc = "Open harpoon window" })
vim.keymap.set("n", "<C-h>", function() harpoon:list():select(1) end)
vim.keymap.set("n", "<C-t>", function() harpoon:list():select(2) end)
vim.keymap.set("n", "<C-n>", function() harpoon:list():select(3) end)
vim.keymap.set("n", "<C-s>", function() harpoon:list():select(4) end)
vim.keymap.set("n", "<C-S-P>", function() harpoon:list():prev() end)
vim.keymap.set("n", "<C-S-N>", function() harpoon:list():next() end)
