local function digitcount(number)
    return math.floor(math.log10(number)+1)
end

local function progress()
  local cur = vim.fn.line('.')
  local col = vim.fn.col('.')
  local total = vim.fn.line('$')
  local linefmtstring = '%' .. digitcount(total) .. 's'
  local rowinfo = ' :' .. string.format(linefmtstring, cur) .. '/' .. total
  local colinfo = ' ℅:' .. string.format('%-3s', col)
  local pct = string.format('%3s', math.floor(cur / total * 100))
  return pct .. '%%' .. rowinfo .. colinfo
end

require("lualine").setup {
    sections = {
        lualine_b = { 'branch', 'diff' },
        lualine_y = { progress },
        lualine_z = {
            {
                'diagnostics',
                sources = { 'coc' },
                sections = { 'error', 'warn' },
                colored = false,
                update_in_insert = true,
                always_visible = true,
                color = function(section)
                    local diags = vim.b.coc_diagnostic_info
                    if diags then
                        if diags.error > 0 then
                            return { fg = 'white', bg = 'red' }
                        elseif diags.warning > 0 then
                            return { fg = 'black', bg = 'yellow' }
                        end
                    end
                    return { fg = 'white', bg = "gray" }
                end,
            },
        }
    }
}
