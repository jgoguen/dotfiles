"use strict";
module.exports = {
	config: {
		// default font size in pixels for all tabs
		fontSize: 12,
		// font family with optional fallbacks
		fontFamily: '"JetBrainsMono Nerd Font"',
		bell: false,
		copyOnSelect: false,
		// if `true` (without backticks and without quotes), hyper will be set as the default protocol client for SSH
		defaultSSHApp: true,
		// if `true` (without backticks and without quotes), on right click selected text will be copied or pasted if no
		// selection is present (`true` by default on Windows and disables the context menu feature)
		quickEdit: false,
		// choose either `'vertical'`, if you want the column mode when Option key is hold during selection (Default)
		// or `'force'`, if you want to force selection regardless of whether the terminal is in mouse events mode
		// (inside tmux or vim with mouse mode enabled for example).
		macOptionSelectionMode: "force",
		// if `false` (without backticks and without quotes), Hyper will use ligatures provided by some fonts
		disableLigatures: false,
		// set to true to disable auto updates
		disableAutoUpdates: false,
		// set to true to preserve working directory when creating splits or tabs
		preserveCWD: false,

		css: `
			.term_fit {
				padding: 0 !important;
			}
		`,

		catppuccinTheme: "mocha",
	},
	// a list of plugins to fetch and install from npm
	// format: [@org/]project[#version]
	// examples:
	//   `hyperpower`
	//   `@company/project`
	//   `project#1.0.1`
	plugins: ["hypurr#latest"],
	// in development, you can create a directory under
	// `~/.hyper_plugins/local/` and include it here
	// to load it and avoid it being `npm install`ed
	localPlugins: [],
	keymaps: {
		// Example
		// 'window:devtools': 'cmd+alt+o',
	},
};
//# sourceMappingURL=config-default.js.map
