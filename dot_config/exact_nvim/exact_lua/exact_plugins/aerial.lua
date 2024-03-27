local M = {
	'stevearc/aerial.nvim',
	keys = {
		{
			'<F8>',
			function()
				require('telescope').extensions.aerial.aerial()
			end,
			silent = true,
		},
		{ '<S-F8>', ':AerialToggle!<CR>', silent = true },
	},
	opts = function(_, opts)
		opts['close_automatic_events'] = { 'unsupported' }
		opts['layout']['min_width'] = 20
		opts['layout']['max_width'] = { 100, 0.2 }
		opts['layout']['default_direction'] = 'right'
		opts['layout']['placement'] = 'window'
		opts['layout']['preserve_equality'] = true
	end,
}

return M
