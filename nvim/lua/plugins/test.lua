return {
    {
        "janko-m/vim-test",
        cmd = {
            "TestNearest",
            "TestFile",
            "TestSuite",
            "TestLast",
            "TestVisit",
        },
        config = function()
            vim.cmd([[let test#strategy = "neoterm"]])
        end
    },
    {
        "nvim-neotest/neotest",
        dependencies = {
            "nvim-neotest/nvim-nio",
            "nvim-lua/plenary.nvim",
            "nvim-treesitter/nvim-treesitter",
            "rouge8/neotest-rust",
            "marilari88/neotest-vitest",
        },
        config = function()
            require("neotest").setup({
                adapters = {
                    require("neotest-rust"),
                    require("neotest-vitest"),
                }
            })
        end,
    },
}
