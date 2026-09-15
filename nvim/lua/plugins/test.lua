return {
    {
        "nvim-neotest/neotest",
        dependencies = {
            "nvim-neotest/nvim-nio",
            "nvim-lua/plenary.nvim",
            "rouge8/neotest-rust",
            "marilari88/neotest-vitest",
        },
        opts = {
            adapters = {
                "neotest-rust",
                "neotest-vitest",
            }
        }
    },
}
