local excluded_filetypes = {
    "tagbar",
    "gundo",
    "minibufexpl",
    "nerdtree",
    "TelescopePrompt",
}

return {
    {
        "nkakouros-original/numbers.nvim",
        opts = {
            excluded_filetypes = excluded_filetypes,
        },
    },
    {
        "luukvbaal/statuscol.nvim",
        config = function()
            local builtin = require("statuscol.builtin")
            require("statuscol").setup({
                relculright = true,
                ft_ignore = excluded_filetypes,
                segments = {
                    {
                        text = { builtin.lnumfunc, " " },
                        click = "v:lua.ScSa",
                    }
                },
                clickhandlers = {
                    ["diagnostics/signs"] = builtin.diagnostic_click
                }
            })
        end
    }
}
