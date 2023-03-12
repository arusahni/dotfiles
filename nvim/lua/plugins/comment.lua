return {
    {
        "numToStr/Comment.nvim",
        event = { "BufReadPost", "BufNewFile" },
        opts = {
            pre_hook = function(ctx)
                -- Only calculate commentstring for Vue filetypes
                if vim.bo.filetype == 'vue' then
                    -- Detemine whether to use linewise or blockwise commentstring
                    local type = ctx.ctype == require("Comment.utils").ctype.line and "__default" or "__multiline"
                    return require("ts_context_commentstring.internal").calculate_commentstring({ key = type })
                end
            end,
        }
    },
}
