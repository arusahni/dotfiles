return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },
    opts = {
        indent = {
            enable = false
        },
        ensure_installed = "all", -- one of "all", "maintained", or a list of languages
        -- List of parsers to ignore installing
        ignore_install = {
            "css",
            "systemverilog",
        },
        highlight = {
            enable = true,  -- enable = true (false will disable the whole extension)
            disable = {},   -- list of language that will be disabled
            -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
            -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
            -- Using this option may slow down your editor, and you may see some duplicate highlights.
            -- Instead of true it can also be a list of languages
            additional_vim_regex_highlighting = false
        }
    },
    config = function(_, opts)
        require("nvim-treesitter.configs").setup(opts)
    end,
}
