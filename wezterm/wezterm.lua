-- Import the wezterm module
local wezterm = require("wezterm")
local appearance = require("appearance")

-- Creates a config object which we will be adding our config to
local config = wezterm.config_builder()
config.leader = { key = "a", mods = "CTRL", timeout_milliseconds = 1000 }

-- + (This is where our config will go)
local function read_theme_mode()
	local theme_file = wezterm.home_dir .. "/.theme-mode"
	local file = io.open(theme_file, "r")
	if file then
		local content = file:read("*all"):gsub("%s+", "")
		file:close()
		return content
	end
	return nil
end

local theme_mode = read_theme_mode()
if theme_mode == "light" then
	config.color_scheme = "Catppuccin Latte"
elseif theme_mode == "dark" then
	config.color_scheme = "Tokyo Night"
else
	-- Fallback to system appearance
	if appearance.is_dark() then
		config.color_scheme = "Tokyo Night"
	else
		config.color_scheme = "Catppuccin Latte"
	end
end

config.font = wezterm.font({ family = "FiraCode Nerd Font Mono" })
config.font_size = 14

config.window_background_opacity = 0.9
config.macos_window_background_blur = 30

config.window_decorations = "INTEGRATED_BUTTONS"

config.adjust_window_size_when_changing_font_size = false

-- More scrollback history (default is 3500)
config.scrollback_lines = 10000

-- Use GPU for better rendering performance on modern Macs
config.front_end = "WebGpu"

-- Dim inactive panes so the active one stands out
config.inactive_pane_hsb = {
	saturation = 0.8,
	brightness = 0.7,
}

local function resize_pane(key, direction)
	return {
		key = key,
		action = wezterm.action.AdjustPaneSize({ direction, 3 }),
	}
end

config.keys = {
	-- word jump in the terminal
	{ key = "RightArrow", mods = "OPT", action = wezterm.action.SendString("\x1bf") },
	-- tmux
	{ key = '"', mods = "LEADER", action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
	{ key = "%", mods = "LEADER", action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }) },
	{ key = "x", mods = "LEADER", action = wezterm.action.CloseCurrentPane({ confirm = false }) },
	-- vim-like pane switching
	{ key = "j", mods = "LEADER", action = wezterm.action.ActivatePaneDirection("Down") },
	{ key = "k", mods = "LEADER", action = wezterm.action.ActivatePaneDirection("Up") },
	{ key = "h", mods = "LEADER", action = wezterm.action.ActivatePaneDirection("Left") },
	{ key = "l", mods = "LEADER", action = wezterm.action.ActivatePaneDirection("Right") },
	-- Tab cycling: Leader+n/p to go next/previous
	{ key = "n", mods = "LEADER", action = wezterm.action.ActivateTabRelative(1) },
	{ key = "p", mods = "LEADER", action = wezterm.action.ActivateTabRelative(-1) },
	-- Pane zoom: temporarily maximize current pane, toggle back with same key
	{ key = "z", mods = "LEADER", action = wezterm.action.TogglePaneZoomState },
	{
		-- When the left arrow is pressed
		key = "LeftArrow",
		-- With the "Option" key modifier held down
		mods = "OPT",
		-- Perform this action, in this case - sending ESC + B
		-- to the terminal
		action = wezterm.action.SendString("\x1bb"),
	},
	{
		-- open wezterm config in nvim when cmd + , is pressed
		key = ",",
		mods = "SUPER",
		action = wezterm.action.SpawnCommandInNewTab({
			cwd = wezterm.home_dir,
			args = { "nvim", wezterm.config_file },
		}),
	},
	{
		-- When we push LEADER + R...
		key = "r",
		mods = "LEADER",
		-- Activate the `resize_panes` keytable
		action = wezterm.action.ActivateKeyTable({
			name = "resize_panes",
			-- Ensures the keytable stays active after it handles its
			-- first keypress.
			one_shot = false,
			-- Deactivate the keytable after a timeout.
			timeout_milliseconds = 1000,
		}),
	},
	{
		-- Reload wezterm config
		key = "F5",
		action = wezterm.action.ReloadConfiguration,
	},
}

config.key_tables = {
	resize_panes = {
		resize_pane("j", "Down"),
		resize_pane("k", "Up"),
		resize_pane("h", "Left"),
		resize_pane("l", "Right"),
	},
}


wezterm.on("update-status", function(window)
	-- Grab the utf8 character for the "powerline" left facing
	-- solid arrow.
	local SOLID_LEFT_ARROW = utf8.char(0xe0b2)

	-- Grab the current window's configuration, and from it the
	-- palette (this is the combination of your chosen colour scheme
	-- including any overrides).
	local color_scheme = window:effective_config().resolved_palette
	local bg = color_scheme.background
	local fg = color_scheme.foreground

	window:set_right_status(wezterm.format({
		-- First, we draw the arrow...
		{ Background = { Color = "none" } },
		{ Foreground = { Color = bg } },
		{ Text = SOLID_LEFT_ARROW },
		-- Then we draw our text
		{ Background = { Color = bg } },
		{ Foreground = { Color = fg } },
		{ Text = " " .. wezterm.hostname() .. " " },
	}))
end)

-- Returns our config to be evaluated. We must always do this at the bottom of this file
return config
