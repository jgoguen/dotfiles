local M = {}

function M.set_compiler(name)
	vim.cmd('compiler ' .. name)
end

function M.set_local_options(opts)
	for key, value in pairs(opts) do
		vim.opt_local[key] = value
	end
end

function M.setup_markup_pairs()
	local TSUtils = require('utils.treesitter')

	vim.keymap.set('i', '=', TSUtils.html_attribute_equals, { buffer = true, expr = true })
	vim.keymap.set('i', '/', TSUtils.html_self_closing, { buffer = true, expr = true })
end

function M.setup_markup(opts)
	opts = opts or {}
	if opts.compiler then
		M.set_compiler(opts.compiler)
	end
	if opts.register_treesitter then
		vim.treesitter.language.register(opts.register_treesitter.parser, opts.register_treesitter.filetype)
	end
	M.setup_markup_pairs()
end

function M.setup_css_important_toggle()
	local Utils = require('utils')

	Utils.set_keymap('n', '<LocalLeader>i', function()
		local line = vim.fn.getline('.')
		if line:find('!important') then
			line = line:gsub(' !important', '')
		else
			line = line:gsub(';', ' !important;')
		end

		vim.fn.setline(vim.fn.line('.'), line)
	end, { buffer = true })
end

function M.setup_css_like(opts)
	opts = opts or {}
	if opts.compiler then
		M.set_compiler(opts.compiler)
	end
	vim.opt_local.iskeyword:append('@-@')
	M.setup_css_important_toggle()
end

function M.setup_commit_message()
	M.set_local_options({
		autoindent = false,
		linebreak = false,
		spell = true,
		textwidth = 0,
	})

	local bufnr = vim.api.nvim_get_current_buf()
	vim.api.nvim_create_autocmd('BufEnter', {
		group = vim.api.nvim_create_augroup('jgoguen_ftplugin_commit_' .. bufnr, { clear = true }),
		buffer = bufnr,
		callback = function()
			vim.api.nvim_win_set_cursor(0, { 1, 0 })
		end,
	})
end

return M
