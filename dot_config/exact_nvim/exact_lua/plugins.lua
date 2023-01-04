local M = {}

function M.setup()
	local utils = require('jgoguen.utils')
	local packer_bootstrap = utils.packer_bootstrap()
	local packer = require('packer')

	packer.startup(function(use)
		-- Plugins that need no configuration
		use('wbthomason/packer.nvim')
		use({'b0o/SchemaStore.nvim', module = 'schemastore'})
		use('https://codeberg.org/jgoguen/tmpl.vim')
		use('nvim-lua/plenary.nvim')
		use('nvim-telescope/telescope-symbols.nvim')
		use('ryanoasis/vim-devicons')

		-- Auto-load plugins that are submodules of 'plugins'
		plugin_configs = vim.api.nvim_get_runtime_file('lua/plugins/*.lua', 1)
		for _, path in ipairs(plugin_configs) do
			local mod = vim.fn.fnamemodify(path, ':t:r')
			use(require('plugins.' .. mod))
		end

		-- Keep this after all plugins are loaded
		if packer_bootstrap then
			packer.sync()
		end
	end)
end

return M
