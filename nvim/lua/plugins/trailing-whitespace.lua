return {
    'bronson/vim-trailing-whitespace',
    event = { "InsertEnter", "BufReadPost", "BufNewFile" },
    config = function()
        vim.cmd([[
            let g:extra_whitespace_ignored_filetypes = ["TelescopePrompt"]
        ]])
    end
}
