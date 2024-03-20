local wezterm = require("wezterm")
local has_site, site_config = pcall(require, "wezterm_local")

local config = {}

local function get_appearance()
	if wezterm.gui then
		return wezterm.gui.get_appearance()
	end
	return "Dark"
end

local function scheme_for_appearance(appearance)
	if appearance:find("Dark") then
		return "Catppuccin Mocha"
		--return "tokyonight_moon"
	else
		return "Catppuccin Latte"
		--return "tokyonight_day"
	end
end

-- Check for Windows
local font_set = {
	"JetBrainsMono Nerd Font Mono",
	"FiraCode Nerd Font Mono",
	"Noto Sans CJK JP",
	"Symbols Nerd Font Mono",
}
local is_windows_11 = false
if wezterm.target_triple == "x86_64-pc-windows-msvc" then
	local _, stdout, _ = wezterm.run_child_process({ "cmd.exe", "ver" })
	local _, _, build, _ = stdout:match("Version ([0-9]+)%.([0-9]+)%.([0-9]+)%.([0-9]+)")
	is_windows_11 = tonumber(build) >= 22000

	font_set[1] = "JetBrainsMono NFM"
end

-- In newer versions of wezterm, use the config builder for better errors
if wezterm.config_builder then
	config = wezterm.config_builder()
end

config.audible_bell = "Disabled"
config.automatically_reload_config = true
config.bold_brightens_ansi_colors = true
config.clean_exit_codes = { 130 }
config.color_scheme = scheme_for_appearance(get_appearance())
config.default_cwd = wezterm.home_dir
config.font = wezterm.font_with_fallback(font_set)
config.font_size = 13
config.harfbuzz_features = { "ss02", "ss03", "ss05", "ss07", "cv22", "cv24", "cv25", "cv26", "cv32" }
-- Explicitly set the defaults here since this might be appended to in site config and we don't want to override the
-- default set of rules.
config.hyperlink_rules = wezterm.default_hyperlink_rules()
config.keys = {
	{ key = "PageUp", mods = "CTRL", action = wezterm.action({ ActivateTabRelative = -1 }) },
	{ key = "LeftArrow", mods = "CMD", action = wezterm.action({ ActivateTabRelative = -1 }) },
	{ key = "PageDown", mods = "CTRL", action = wezterm.action({ ActivateTabRelative = 1 }) },
	{ key = "RightArrow", mods = "CMD", action = wezterm.action({ ActivateTabRelative = 1 }) },
	{ key = "t", mods = "CMD", action = wezterm.action({ SpawnCommandInNewTab = { cwd = wezterm.home_dir } }) },
	{ key = "t", mods = "SHIFT|CTRL", action = wezterm.action({ SpawnCommandInNewTab = { cwd = wezterm.home_dir } }) },
	{ key = "w", mods = "CMD", action = wezterm.action.CloseCurrentTab({ confirm = false }) },
	{ key = "w", mods = "SHIFT|CTRL", action = wezterm.action.CloseCurrentTab({ confirm = false }) },
	{ key = "r", mods = "CTRL", action = wezterm.action.EmitEvent("do-resize-window") },
}
config.mouse_bindings = {
	{
		event = { Down = { streak = 3, button = "Left" } },
		action = wezterm.action.SelectTextAtMouseCursor("SemanticZone"),
		mods = "NONE",
	},
}
config.native_macos_fullscreen_mode = true
config.quote_dropped_files = is_windows_11 and "Windows" or "Posix"
config.selection_word_boundary = " \t\n{}[]()\"'`:"
config.visual_bell = {
	fade_in_duration_ms = 75,
	fade_out_duration_ms = 75,
	target = "CursorColor",
}
config.window_close_confirmation = "NeverPrompt"
config.window_decorations = "RESIZE|MACOS_FORCE_DISABLE_SHADOW|INTEGRATED_BUTTONS"

if is_windows_11 then
	config.default_prog = { "pwsh.exe", "-NoLogo" }
end

if has_site then
	config = site_config.update_config(config)
end

wezterm.on("format-tab-title", function(tab)
	local pane_title = tab.active_pane.title
	local user_title = tab.active_pane.user_vars.panetitle

	if user_title ~= nil and #user_title > 0 then
		pane_title = user_title
	end

	return {
		{ Text = " " .. pane_title .. " " },
	}
end)

local reset_window_size = function(gui_window)
	local screen = wezterm.gui.screens()["active"]

	-- Set default WezTerm size to a good chunk of the screen
	gui_window:set_inner_size(screen.width / 1.5, screen.height / 1.5)
	gui_window:set_position(screen.width / 6, screen.height / 9)
end

wezterm.on("gui-startup", function(cmd)
	local _, _, window = wezterm.mux.spawn_window(cmd or {})
	reset_window_size(window:gui_window())
end)

wezterm.on("do-resize-window", function(window)
	reset_window_size(window)
end)

return config
