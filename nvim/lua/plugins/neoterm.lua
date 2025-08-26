return {
    {
        "kassio/neoterm",
        event = "VeryLazy",
        config = function()
            vim.cmd([[
            let g:neoterm_default_mod = 'vertical'
            let g:neoterm_autoscroll = 1
            ]])
        end
    }
}
