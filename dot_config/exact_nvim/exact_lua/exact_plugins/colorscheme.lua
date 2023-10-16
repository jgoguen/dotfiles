-- Do not edit this file directly! It is managed by chezmoi.

return {
	{
		'folke/tokyonight.nvim',
		opts = {
			style = 'moon',
			styles = {
				comments = {
					italic = false,
				},
				keywords = {
					italic = false,
				},
			},
			sidebars = {
				'help',
				'lazy',
				'qf',
				'terminal',
			},
		},
	},
	{
		'LazyVim/LazyVim',
		opts = {
			colorscheme = 'tokyonight',
		},
	},
}
