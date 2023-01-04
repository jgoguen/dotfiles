local M = {
	cmp_source_priority = {
		nvim_lsp = 1000,
		nvim_lsp_signature_help = 900,
		omni = 800,
		luasnip = 750,
		emoji = 700,
		pandoc_references = 700,
		latex_symbols = 700,
		calc = 650,
		path = 500,
		buffer = 250,
	},
	excluded_filetypes = {
		'dashboard',
		'neogitstatus',
		'NvimTree',
		'neo-tree',
		'neo-tree-popup',
		'notify',
		'packer',
		'TelescopePrompt',
		'Trouble',
	},
	excluded_buftypes = {
		'nofile',
		'prompt',
		'quickfix',
		'terminal',
	},
	project_root_files = {
		'Makefile',
		'.git',
		'.hg',
	},
}

-- Take the cmp source string or table and return a source table.
-- See nvim-cmp documentation for the format of the source table.
function M.get_cmp_source(source)
	local cmp_src = type(source) == 'string' and {name = source} or source

	local priority = M.cmp_source_priority[cmp_src.name]
	if priority then
		cmp_src.priority = priority
	end

	return cmp_src
end

-- Takes a cmp source table and adds it to nvim-cmp
function M.add_cmp_source(source)
	local has_cmp, cmp = pcall(require, 'cmp')
	if not has_cmp then return end

	local config = cmp.get_config()
	table.insert(config.sources, source)

	cmp.setup(config)
end

function M.get_icon(name)
	local icons = require('jgoguen.icons')
	return icons[name] or ''
end

function M.lspkind_opts()
	return {
		mode = 'symbol_text',
		symbol_map = {
			NONE = '',
			Array = M.get_icon('Array'),
			Boolean = M.get_icon('Boolean'),
			Class = M.get_icon('Class'),
			Constructor = M.get_icon('Build'),
			Key = M.get_icon('Key'),
			Namespace = M.get_icon('Array'),
			Null = "NULL",
			Number = "#",
			Object = M.get_icon('BorderFilledCircle'),
			Package = M.get_icon('Package'),
			Property = M.get_icon('Setting'),
			Reference = M.get_icon('Link'),
			Snippet = M.get_icon('Cut'),
			String = M.get_icon('Font'),
			TypeParameter = M.get_icon('TypeParameter'),
			Unit = M.get_icon('AngleRuler'),
		},
	}
end

function M.packer_bootstrap()
	local packerpath = vim.fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
	if not vim.loop.fs_stat(packerpath) then
		vim.fn.system({'git', 'clone', '--depth=1', 'https://github.com/wbthomason/packer.nvim', packerpath})
		vim.cmd('packadd packer.nvim')
		return true
	end
	return false
end

return M
