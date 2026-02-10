return {
    {
        "navarasu/onedark.nvim",
        lazy = false,
        priority = 1000,
        config = function()
            require("onedark").setup({
                style = "darker",
                transparent = true,
            })
            require("onedark").load()
        end,
    },
    {
        "scottmckendry/cyberdream.nvim",
        lazy = false,
        priority = 1000,
        opts = {
            italic_comments = true,
        },
    },
    -- {
    --   "olimorris/onedarkpro.nvim",
    --   priority = 1000, -- Ensure it loads first
    -- },
    {
        "catppuccin/nvim",
        name = "catppuccin",
        lazy = false,
        priority = 1000,
        config = function()
            require("catppuccin").setup({
                color_overrides = {
                    mocha = {
                        rosewater = "#efc9c2",
                        flamingo = "#ebb2b2",
                        pink = "#f2a7de",
                        mauve = "#b889f4",
                        red = "#ea7183",
                        maroon = "#ea838c",
                        peach = "#f39967",
                        yellow = "#eaca89",
                        green = "#96d382",
                        teal = "#78cec1",
                        sky = "#91d7e3",
                        sapphire = "#68bae0",
                        blue = "#739df2",
                        lavender = "#a0a8f6",
                        text = "#b5c1f1",
                        subtext1 = "#a6b0d8",
                        subtext0 = "#959ec2",
                        overlay2 = "#848cad",
                        overlay1 = "#717997",
                        overlay0 = "#63677f",
                        surface2 = "#505469",
                        surface1 = "#3e4255",
                        surface0 = "#2c2f40",
                        base = "#0e0f16",
                        mantle = "#0e0f16",
                        crust = "#0e0f16",
                    }
                },
                integrations = {
                    native_lsp = {
                        underlines = {
                            errors = { "undercurl" },
                            hints = { "undercurl" },
                            warnings = { "undercurl" },
                            information = { "undercurl" },
                        }
                    }
                }
            })
        end,
    }
}
