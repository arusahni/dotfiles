return {
    {
        "nvim-neotest/neotest",
        dependencies = {
            "nvim-neotest/nvim-nio",
            "nvim-lua/plenary.nvim",
            "rouge8/neotest-rust",
            "marilari88/neotest-vitest",
            "antoinemadec/FixCursorHold.nvim",
            {
                "nvim-treesitter/nvim-treesitter", -- Optional, but recommended
                branch = "main",                   -- NOTE; not the master branch!
                build = function()
                    vim.cmd(":TSUpdate go")
                end,
            },
            {
                "fredrikaverpil/neotest-golang",
                version = "*",                                                              -- Optional, but recommended; track releases
            },
        },
        config = function()
            local config = {
                runner = "gotestsum", -- Optional, but recommended
            }
            require("neotest").setup({
                adapters = {
                    require("neotest-rust"),
                    require("neotest-vitest"),
                    require("neotest-golang")(config)
                }
            })
        end,
    },
}
