return {
    {
        "iamcco/markdown-preview.nvim",
        config = function()
            vim.fn["mkdp#util#install"]()
        end,
    },
    {
        "junegunn/goyo.vim",
        cmd = {
            "Goyo",
        }
    }
}
