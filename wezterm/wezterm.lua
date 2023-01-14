local wezterm = require("wezterm")

-- From https://stackoverflow.com/a/15434737/214197
function isModuleAvailable(name)
  if package.loaded[name] then
    return true
  else
    for _, searcher in ipairs(package.searchers or package.loaders) do
      local loader = searcher(name)
      if type(loader) == 'function' then
        package.preload[name] = loader
        return true
      end
    end
    return false
  end
end

local merge = function(a, b)
    local c = {}
    for k,v in pairs(a) do c[k] = v end
    for k,v in pairs(b) do c[k] = v end
    return c
end

local overrides = {}

if isModuleAvailable("local") then
    overrides = require("local")
end

return merge({
    color_scheme = "midnight-in-mojave",
    colors = {
        -- Overrides the cell background color when the current cell is occupied by the
        -- cursor and the cursor style is set to Block
        cursor_bg = "#fff",
        -- Specifies the border color of the cursor when the cursor style is set to Block,
        -- or the color of the vertical or horizontal bar when the cursor style is set to
        -- Bar or Underline.
        cursor_border = "#fff",
        scrollbar_thumb = "#444",
    },
    cursor_blink_rate = 1000,
    enable_scroll_bar = true,
    hide_tab_bar_if_only_one_tab = true,
    mouse_bindings = {
        -- Disable the default click behavior
        {
          event = { Up = { streak = 1, button = "Left"} },
          mods = "NONE",
          action = wezterm.action.DisableDefaultAssignment,
        },
        -- Ctrl-click will open the link under the mouse cursor
        {
            event = { Up = { streak = 1, button = "Left" } },
            mods = "CTRL",
            action = wezterm.action.OpenLinkAtMouseCursor,
        },
        -- Disable the Ctrl-click down event to stop programs from seeing it when a URL is clicked
        {
            event = { Down = { streak = 1, button = "Left" } },
            mods = "CTRL",
            action = wezterm.action.Nop,
        },
    },
    scrollback_lines = 99999,
    tab_bar_at_bottom = true,
    unix_domains = {
        { name = "dropdown" },
    },
    use_fancy_tab_bar = false,
  }, overrides)
