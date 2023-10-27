local wezterm = require("wezterm")
local has_site, site_config = pcall(require, "wezterm_local")

local config = {}

-- In newer versions of wezterm, use the config builder for better errors
if wezterm.config_builder then
	config = wezterm.config_builder()
end

config.automatically_reload_config = true
config.bold_brightens_ansi_colors = true
config.clean_exit_codes = { 130 }
config.color_scheme = "tokyonight_moon"
config.font = wezterm.font_with_fallback({
	"JetBrainsMono Nerd Font",
	"FiraCode Nerd Font",
	"Fira Code",
	"Noto Sans CJK JP",
	"Symbols Nerd Font",
})
config.font_size = 13
config.harfbuzz_features = { "ss02", "ss03", "ss05", "ss07", "cv22", "cv24", "cv25", "cv26", "cv32" }
config.hyperlink_rules = {
	-- Include the default since we're overriding
	{
		regex = "\\b\\w+://(?:[\\w.-]+)\\.[a-z]{2,15}\\S*\\b",
		format = "$0",
	},
}
config.keys = {
	{ key = "PageUp", mods = "CTRL", action = wezterm.action({ ActivateTabRelative = -1 }) },
	{ key = "LeftArrow", mods = "CMD", action = wezterm.action({ ActivateTabRelative = -1 }) },
	{ key = "PageDown", mods = "CTRL", action = wezterm.action({ ActivateTabRelative = 1 }) },
	{ key = "RightArrow", mods = "CMD", action = wezterm.action({ ActivateTabRelative = 1 }) },
	{ key = "w", mods = "CMD", action = wezterm.action.CloseCurrentTab({ confirm = false }) },
	{ key = "w", mods = "SHIFT|CTRL", action = wezterm.action.CloseCurrentTab({ confirm = false }) },
}
config.selection_word_boundary = " \t\n{}[]()\"'`:"
config.window_close_confirmation = "NeverPrompt"

if has_site then
	config = site_config.update_config(config)
end

return config
