local M = {
	'windwp/nvim-autopairs',
	after = 'nvim-cmp',
}

function M.config()
	require('nvim-autopairs').setup({
		check_ts = true,
		ts_config = {
			java = false,
		},
		fast_wrap = {
			map = '<M-e>',
			chars = { '{', '[', '(', '"', "'" },
			pattern = string.gsub([[ [%'%"%)%>%]%)%}%,] ]], '%s+', ''),
			offset = 0,
			end_key = '$',
			keys = 'qwertyuiopzxcvbnmasdfghjkl',
			check_comma = true,
			highlight = 'PmenuSel',
			highlight_grey = 'LineNr',
		},
	})

	local cmp = require('cmp')
	local autopair_cmp = require('nvim-autopairs.completion.cmp')
	local handlers = require('nvim-autopairs.completion.handlers')
	cmp.event:on(
		'confirm_done',
		autopair_cmp.on_confirm_done({
			filetypes = {
				['*'] = {
					['('] = {
						kind = {
							cmp.lsp.CompletionItemKind.Function,
							cmp.lsp.CompletionItemKind.Method,
						},
						handler = handlers["*"]
					},
				},
				latex = false,
				tex = false,
			},
		})
	)
end

return M
