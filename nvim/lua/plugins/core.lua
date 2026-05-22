return {
    {
        "tpope/vim-repeat",
        event = { "InsertEnter", "BufReadPost", "BufNewFile" },
    },

    {
        "kyazdani42/nvim-tree.lua",
        dependencies = {
            "kyazdani42/nvim-web-devicons"
        },
        cmd = "NvimTreeToggle",
        config = true,
        lazy = true,
        opts = {
            view = {
                side = "right",
            },
        },
    },

    {
        "tpope/vim-surround",
        event = { "InsertEnter", "BufReadPost", "BufNewFile" }
    },

    {
        "tpope/vim-fugitive",
        event = "VeryLazy"
    },

    {
        "almo7aya/openingh.nvim",
        event = "VeryLazy",
    },

    {
        "tpope/vim-rhubarb",
        event = "VeryLazy"
    },

    {
        "tpope/vim-eunuch",
        event = "VeryLazy"
    },

    "thinca/vim-localrc",
    {
        "nvim.undotree",
        dir = vim.env.VIMRUNTIME .. "/pack/dist/opt/nvim.undotree",
        event = { "BufReadPost", "BufNewFile" },
    },
    {
        "wellle/targets.vim",
        event = { "InsertEnter", "BufReadPost", "BufNewFile" }
    },

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
        event = { "InsertEnter", "BufReadPost", "BufNewFile" },
        config = true,
    },

    {
        "weihanglo/polar.vim" ,
        event = { "InsertEnter", "BufReadPost", "BufNewFile" },
    }
}
