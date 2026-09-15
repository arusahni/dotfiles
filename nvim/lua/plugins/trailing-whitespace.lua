return {
    'bronson/vim-trailing-whitespace',
    event = { "InsertEnter", "BufReadPost", "BufNewFile" },
    config = function()
        vim.g.extra_whitespace_ignored_filetypes = {
            "TelescopePrompt",
            "blink-cmp-menu",
            "blink-cmp-documentation",
            "blink-cmp-signature",
        }
    end
}
