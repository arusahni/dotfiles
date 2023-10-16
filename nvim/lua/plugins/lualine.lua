local function digitcount(number)
    return math.floor(math.log10(number) + 1)
end

local function progress()
    local cur = vim.fn.line('.')
    local col = vim.fn.col('.')
    local total = vim.fn.line('$')
    local linefmtstring = '%' .. digitcount(total) .. 's'
    local rowinfo = ' :' .. string.format(linefmtstring, cur) .. '/' .. total
    local colinfo = ' ℅:' .. string.format('%-3s', col)
    -- local pct = string.format('%3s', math.floor(cur / total * 100))
    -- return pct .. '%%' .. rowinfo .. colinfo
    return rowinfo .. colinfo
end

return {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    dependencies = { "kyazdani42/nvim-web-devicons" },
    opts = {
        sections = {
            lualine_b = { "branch", "diff" },
            lualine_c = {
                {
                    "filename",
                    path = 1,
                }
            },
            lualine_y = { progress },
            lualine_z = {
                {
                    "diagnostics",
                    sources = { "nvim_diagnostic" },
                    sections = { "error", "warn" },
                    colored = false,
                    update_in_insert = true,
                    always_visible = true,
                    diagnostics_color = {
                        error = "DiagnosticError",
                        warn = "DiagnosticWarn",
                    },
                    on_click = function()
                        require("telescope.builtin").diagnostics()
                    end,
                    color = function(_section)
                        local error_count = vim.tbl_count(vim.diagnostic.get(0,
                            { severity = vim.diagnostic.severity.ERROR }))
                        local warn_count = vim.tbl_count(vim.diagnostic.get(0,
                            { severity = vim.diagnostic.severity.WARN }))
                        if error_count > 0 then
                            return { fg = "white", bg = "red" }
                        elseif warn_count > 0 then
                            return { fg = "black", bg = "yellow" }
                        end
                        return { fg = "white", bg = "gray" }
                    end,
                },
            }
        }
    }
}
