return {
    'bronson/vim-trailing-whitespace',
    event = "VeryLazy",
    config = function()
        vim.cmd([[
            let g:extra_whitespace_ignored_filetypes = ["TelescopePrompt"]
        ]])
    end
}
