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

local function get_current_working_dir(tab)
	local current_dir = tab.active_pane.current_working_dir
	local HOME_DIR = string.format("file://%s", os.getenv("HOME"))

	return current_dir == HOME_DIR and "~"
		or string.format("%s", string.gsub(current_dir, "(.*[/\\])(.*)", "%2"))
end

local function get_process(tab)
	local process_icons = {
		["docker"] = {
			-- { Foreground = { Color = colors.blue } },
			{ Text = wezterm.nerdfonts.linux_docker },
		},
		["docker-compose"] = {
			-- { Foreground = { Color = colors.blue } },
			{ Text = wezterm.nerdfonts.linux_docker },
		},
		["nvim"] = {
			-- { Foreground = { Color = colors.green } },
			{ Text = wezterm.nerdfonts.custom_vim },
		},
		["vim"] = {
			-- { Foreground = { Color = colors.green } },
			{ Text = wezterm.nerdfonts.dev_vim },
		},
		["node"] = {
			-- { Foreground = { Color = colors.green } },
			{ Text = wezterm.nerdfonts.mdi_hexagon },
		},
		["zsh"] = {
			-- { Foreground = { Color = colors.peach } },
			{ Text = wezterm.nerdfonts.dev_terminal },
		},
		["bash"] = {
			-- { Foreground = { Color = colors.subtext0 } },
			{ Text = wezterm.nerdfonts.cod_terminal_bash },
		},
		["pacman"] = {
			-- { Foreground = { Color = colors.lavender } },
			{ Text = wezterm.nerdfonts.linux_archlinux },
		},
		["htop"] = {
			-- { Foreground = { Color = colors.yellow } },
			{ Text = wezterm.nerdfonts.mdi_chart_donut_variant },
		},
		["cargo"] = {
			-- { Foreground = { Color = colors.peach } },
			{ Text = wezterm.nerdfonts.dev_rust },
		},
		["go"] = {
			-- { Foreground = { Color = colors.sapphire } },
			{ Text = wezterm.nerdfonts.mdi_language_go },
		},
		["docker"] = {
			-- { Foreground = { Color = colors.blue } },
			{ Text = wezterm.nerdfonts.linux_docker },
		},
		["git"] = {
			-- { Foreground = { Color = colors.peach } },
			{ Text = wezterm.nerdfonts.dev_git },
		},
		["lua"] = {
			-- { Foreground = { Color = colors.blue } },
			{ Text = wezterm.nerdfonts.seti_lua },
		},
		["wget"] = {
			-- { Foreground = { Color = colors.yellow } },
			{ Text = wezterm.nerdfonts.mdi_arrow_down_box },
		},
		["curl"] = {
			-- { Foreground = { Color = colors.yellow } },
			{ Text = wezterm.nerdfonts.mdi_flattr },
		}
	}

	local process_name = string.gsub(tab.active_pane.foreground_process_name, "(.*[/\\])(.*)", "%2")

	return wezterm.format(
		process_icons[process_name]
			or { { Text = string.format("[%s]", process_name) } }
	)
end

wezterm.on("format-tab-title", function(tab)
	return wezterm.format({
		{ Attribute = { Intensity = "Half" } },
		{ Text = string.format(" %s ", tab.tab_index + 1) },
		"ResetAttributes",
		{ Text = get_process(tab) },
		{ Text = string.format("  %s", tab.active_pane.title) },
		-- { Text = get_current_working_dir(tab) },
		-- { Foreground = { Color = colors.base } },
		{ Text = "  ▕" },
	})
end)

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
    front_end = "WebGpu",
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
