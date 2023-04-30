return {
    {
        "tpope/vim-repeat",
        event = "VeryLazy"
    },

    {
        "kyazdani42/nvim-tree.lua",
        dependencies = {
            "kyazdani42/nvim-web-devicons"
        },
        cmd = "NvimTreeToggle",
        config = true,
    },

    {
        "tpope/vim-surround",
        event = { "BufReadPost", "BufNewFile" }
    },

    {
        "tpope/vim-fugitive",
        event = "VeryLazy"
    },

    {
        "tpope/vim-eunuch",
        event = "VeryLazy"
    },

    "thinca/vim-localrc",

    {
        "simnalamburt/vim-mundo",
        event = "VeryLazy"
    },

    {
        "wellle/targets.vim",
        event = { "BufReadPost", "BufNewFile" }
    },

    -- {
    --     "neoclide/coc.nvim",
    --     event = "VeryLazy",
    --     branch = 'release',
    --     build =
    --     ':CocInstall coc-json coc-yaml coc-snippets coc-ultisnips coc-css coc-eslint coc-prettier coc-tsserver coc-vetur coc-pyright coc-rust-analyzer coc-elixir coc-diagnostic coc-stylelint coc-flutter'
    -- },

    {
        "JoosepAlviste/nvim-ts-context-commentstring",
        lazy = true
    },

    {
        "junegunn/vim-easy-align",
        event = "VeryLazy"
    },

    {
        "NvChad/nvim-colorizer.lua",
        event = { "BufReadPost", "BufNewFile" },
        config = true,
    },

    "gpanders/editorconfig.nvim",
}
