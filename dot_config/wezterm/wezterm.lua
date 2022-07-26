local wezterm = require 'wezterm'
local has_site, site_config = pcall(require, 'wezterm_local')

local config = {
	bold_brightens_ansi_colors = true,
	clean_exit_codes = {130},
	color_scheme = "tokyonight",
	font = wezterm.font_with_fallback({
		"FiraCode Nerd Font Mono",
		"FiraCode Nerd Font",
	}),
	harfbuzz_features = { "ss02", "ss03", "ss05", "ss07" },
	window_close_confirmation = "NeverPrompt",
	keys = {
		{ key = "PageUp", mods = "CTRL", action = wezterm.action { ActivateTabRelative = -1 } },
		{ key = "LeftArrow", mods = "CMD", action = wezterm.action { ActivateTabRelative = -1 } },
		{ key = "PageDown", mods = "CTRL", action = wezterm.action { ActivateTabRelative = 1 } },
		{ key = "RightArrow", mods = "CMD", action = wezterm.action { ActivateTabRelative = 1 } },
	},
	hyperlink_rules = {
		-- Include the default since we're overriding
		{
			regex = "\\b\\w+://(?:[\\w.-]+)\\.[a-z]{2,15}\\S*\\b",
			format = "$0",
		},
	},
	selection_word_boundary = " \t\n{}[]()\"'`:",
}

if has_site then
	config = site_config.update_config(config)
end

return config
