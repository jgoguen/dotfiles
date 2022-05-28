local present, wk = pcall(require, "which-key")
if not present then
	return
end

wk.setup({
	plugins = {
		marks = false,
	},
})

wk.register(
	{
		c = {
			l = { ':<C-U>call utils#ToggleCursorColumn()<CR>', 'Toggle Cursor Column' },
		},
		f = {
			c = { ':Fern . -drawer -reveal=% -toggle<CR>', 'Toggle Fern' },
		},
		l = {
			c = { ':lclose<CR>', 'Close Location List' },
			n = { ':lnext<CR>', 'Next Location List Entry' },
			p = { ':lprevious<CR>', 'Previous Location List Entry' },
		},
		m = {
			c = { '/\v^[<\\|=>]{7}( .*\\|$)<CR>', 'Find Conflict markers' },
			p = { '<Plug>MarkdownPreviewToggle', 'Toggle Markdown Preview' },
		},
		q = {
			c = { ':cclose<CR>', 'Close Quickfix Window' },
			n = { ':cnext<CR>', 'Next Quickfix Entry' },
			p = { ':cprevious<CR>', 'Previous Quickfix Entry' },
		},
		s = {
			s = { ':call utils#StripTrailingWhitespaces()<CR>', 'Strip Trailing Whitespace' },
		},
	},
	{
		prefix = '<Leader>',
	}
)

wk.register({
	z = {
		['?'] = { ":execute ':spellrare ' . expand('<cWORD>')<CR>", 'Mark Word as Rare' },
	},
}, {})
