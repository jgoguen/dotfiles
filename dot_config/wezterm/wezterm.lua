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
config.font = wezterm.font_with_fallback({
	"JetBrainsMono Nerd Font Mono",
	"FiraCode Nerd Font Mono",
	"Noto Sans CJK JP",
	"Symbols Nerd Font Mono",
})
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
}
config.native_macos_fullscreen_mode = true
config.quote_dropped_files = "Posix"
config.selection_word_boundary = " \t\n{}[]()\"'`:"
config.visual_bell = {
	fade_in_duration_ms = 75,
	fade_out_duration_ms = 75,
	target = "CursorColor",
}
config.window_close_confirmation = "NeverPrompt"
config.window_decorations = "RESIZE|MACOS_FORCE_DISABLE_SHADOW|INTEGRATED_BUTTONS"

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

return config
