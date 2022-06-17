local wezterm = require 'wezterm'

local config = {
	bold_brightens_ansi_colors = true,
	clean_exit_codes = {130},
	color_scheme = "tokyonight",
	font = wezterm.font_with_fallback({
		"FiraCode Nerd Font Mono",
		"FiraCode Nerd Font",
	}),
	font_antialias = "Subpixel",
	font_hinting = "Full",
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

local config_dir = os.getenv("XDG_CONFIG_HOME")
if config_dir == nil then
	config_dir = os.getenv("HOME") .. "/.config"
end
local local_file = config_dir .. "/wezterm/wezterm.local.lua"

local local_f = io.open(local_file, "r")
if local_f ~= nil then
	io.close(local_f)
	dofile(local_file)
end

return config
