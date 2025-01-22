local function sources_builder(buf, _)
    local sources = require("dropbar.sources")
    local utils = require("dropbar.utils")
    if vim.bo[buf].ft == "markdown" then
        return {
            sources.markdown,
        }
    end
    if vim.bo[buf].buftype == "terminal" then
        return {
            sources.terminal,
        }
    end
    return {
        utils.source.fallback({
            sources.lsp,
            sources.treesitter,
        }),
    }
end

return {
    "Bekaboo/dropbar.nvim",
    -- optional, but required for fuzzy finder support
    dependencies = {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make"
    },

    config = function()
        local dropbar_api = require("dropbar.api")
        vim.keymap.set('n', '<Leader>;', dropbar_api.pick, { desc = 'Pick symbols in winbar' })
        vim.keymap.set('n', '[;', dropbar_api.goto_context_start, { desc = 'Go to start of current context' })
        vim.keymap.set('n', '];', dropbar_api.select_next_context, { desc = 'Select next context' })

        require("dropbar").setup({
            bar = {
                sources = sources_builder,
            }
        })
    end,
}
