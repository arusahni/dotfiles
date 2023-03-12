return {
    'lukas-reineke/indent-blankline.nvim',
    event = { "BufReadPost", "BufNewFile" },
    opts = {
        show_current_context = true,
        show_current_context_start = false,
    }
}
