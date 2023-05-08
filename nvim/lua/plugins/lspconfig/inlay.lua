local M = {}

function M.setup()
    local ih = require("inlay-hints")
    ih.setup({
        hints = {
            parameter = {
                highlight = "CocInlayHint",
            },
            type = {
                highlight = "CocInlayHint",
            },
        },
        eol = {
            parameter = {
                format = function(hints)
                    return string.format("(%s)", hints)
                end
            },
            type = {
                format = function(hints)
                    return string.format("󰞔 %s", hints)
                end
            },
        }
    })
    return ih
end

return M
