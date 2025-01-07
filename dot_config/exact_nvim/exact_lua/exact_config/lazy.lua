-- Do not edit this file directly! It is managed by chezmoi.

local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if vim.uv == nil then
	vim.uv = vim.loop
end
if not vim.uv.fs_stat(lazypath) then
	-- bootstrap lazy.nvim
	-- stylua: ignore
	vim.fn.system({ 'git', 'clone', '--filter=blob:none', 'https://github.com/folke/lazy.nvim.git', '--branch=stable', lazypath })
end
vim.opt.rtp:prepend(vim.env.LAZY or lazypath)

local vim_local_base = XDG_CONFIG_HOME .. '/vim-local'
if vim.fn.isdirectory(vim_local_base) == 1 then
	vim.opt.rtp:append(vim_local_base)

	if vim.fn.isdirectory(vim_local_base .. '/after') == 1 then
		vim.opt.rtp:append(vim_local_base .. '/after')
	end
end

local lazy_specs = {
	-- add LazyVim and import its plugins
	{ 'LazyVim/LazyVim', import = 'lazyvim.plugins' },
	-- import any extras modules here
	{ import = 'lazyvim.plugins.extras.coding.mini-surround' },
	{ import = 'lazyvim.plugins.extras.editor.aerial' },
	{ import = 'lazyvim.plugins.extras.editor.telescope' },
	{ import = 'lazyvim.plugins.extras.formatting.prettier' },
	{ import = 'lazyvim.plugins.extras.lang.clangd' },
	{ import = 'lazyvim.plugins.extras.lang.docker' },
	{ import = 'lazyvim.plugins.extras.lang.git' },
	{ import = 'lazyvim.plugins.extras.lang.go' },
	{ import = 'lazyvim.plugins.extras.lang.json' },
	{ import = 'lazyvim.plugins.extras.lang.markdown' },
	{ import = 'lazyvim.plugins.extras.lang.omnisharp' },
	{ import = 'lazyvim.plugins.extras.lang.python' },
	{ import = 'lazyvim.plugins.extras.lang.rust' },
	{ import = 'lazyvim.plugins.extras.lang.toml' },
	{ import = 'lazyvim.plugins.extras.lang.yaml' },
	{ import = 'lazyvim.plugins.extras.test.core' },
	{ import = 'lazyvim.plugins.extras.ui.treesitter-context' },
	-- import/override with your plugins
	{ import = 'plugins' },
	{ import = 'plugins.lang' },
}

local HasLocalLazy, LocalLazy = pcall(require, 'local.lazyspec')
if HasLocalLazy then
	for _, p in ipairs(LocalLazy) do
		table.insert(lazy_specs, p)
	end
end

if vim.fn.isdirectory(vim_local_base .. '/lua/plugins/local') == 1 then
	table.insert(lazy_specs, { import = 'plugins.local' })
end

require('lazy').setup({
	spec = lazy_specs,
	concurrency = 5,
	lockfile = vim.fn.stdpath('data') .. '/lazy-lock.json',
	defaults = {
		-- By default, only LazyVim plugins will be lazy-loaded. Your custom plugins will load during startup.
		-- If you know what you're doing, you can set this to `true` to have all your custom plugins lazy-loaded by default.
		lazy = false,
		-- It's recommended to leave version=false for now, since a lot the plugin that support versioning,
		-- have outdated releases, which may break your Neovim install.
		version = false, -- always use the latest git commit
		-- version = '*', -- try installing the latest stable version for plugins that support semver
	},
	install = { colorscheme = { 'tokyonight', 'habamax' } },
	checker = { enabled = true }, -- automatically check for plugin updates
	performance = {
		rtp = {
			paths = {
				XDG_CONFIG_HOME .. '/vim-local',
				XDG_CONFIG_HOME .. '/vim-local/after',
			},
			-- disable some rtp plugins
			disabled_plugins = {
				'gzip',
				-- 'matchit',
				-- 'matchparen',
				-- 'netrwPlugin',
				'tarPlugin',
				'tohtml',
				'tutor',
				'zipPlugin',
			},
		},
	},
})

vim.api.nvim_set_hl(0, 'LineNr', { fg = '#4b547d' })
vim.api.nvim_set_hl(0, 'CursorLineNr', { fg = '#4b547d' })
vim.api.nvim_set_hl(0, 'Comment', { fg = '#899497', italic = true })
vim.api.nvim_set_hl(0, '@comment', { fg = '#899497', italic = true })

local SnippetsDir = vim.fn.stdpath('data') .. '/snippets'
if vim.fn.isdirectory(SnippetsDir) then
	local HasLuasnipLoader, LuasnipLoader = pcall(require, 'luasnip.loaders.from_lua')
	if HasLuasnipLoader then
		LuasnipLoader.load({ paths = SnippetsDir })
	end
end

vim.filetype.add({
	extension = {
		gotmpl = 'gotmpl',
		sh = 'sh',
		zsh = 'sh',
	},
	filename = {
		['.infra/deploy.yml'] = 'helm',
	},
	pattern = {
		['(.*/)?chezmoi/.+%.tmpl'] = 'gotmpl',
		['(.*/)?%.infra/helm/.+%.yml'] = 'helm',
		['${HOME}/%.z.+'] = 'sh',
		['${XDG_DATA_HOME}/zsh/.*'] = 'sh',
	},
})
