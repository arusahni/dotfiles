return {
    "nkakouros-original/numbers.nvim",
    opts = {
        excluded_filetypes = {
            "tagbar",
            "gundo",
            "minibufexpl",
            "nerdtree",
            "TelescopePrompt",
        }
    },
    config = function(_, opts)
        require "numbers".setup(opts)
    end,
}
