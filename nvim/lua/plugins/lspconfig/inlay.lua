local M = {}

function M.setup()
    local ih = require("inlay-hints")
    ih.setup({ autocmd = { enable = false } })
    return ih
end

return M
