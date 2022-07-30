local settings_paths = {
	"settings/*.vim",
	"settings/plugins/*.vim",
	"settings/post/*.vim",
}

local config = {
	-- Configure AstroNvim updates
	updater = {
		remote = "origin",
		channel = "stable",
		version = "latest",
		pin_plugins = nil,
		skip_prompts = false,
		show_changelog = true,
	},

	ui = {
		telescope_select = true,
	},

	colorscheme = 'tokyonight',

	polish = function()
		local has_telescope, telescope = pcall(require, 'telescope')
		if has_telescope then
			telescope.load_extension('fzf')
		end

		require("keybindings").setup()

		-- Also scan current and included files for defined name or macro
		vim.opt.complete:append({
			d = true,
		})

		-- Shorten messages
		-- m - Use [+] instead of [modified]
		-- r - Use [RO] instead of [readonly]
		-- I - Don't give the :intro message when starting vim
		vim.opt.shortmess:append({
			m = true,
			r = true,
			I = true,
		})

		-- Allow backspacing over everything in insert mode, C-w and C-u do not stop at
		-- start of insert
		vim.cmd([[set backspace=indent,eol,nostop]])

		-- Set a custom foldmarker to not conflict with templates
		vim.cmd("set foldmarker=[[[,]]]")

		-- listchars options [[[
		-- tab:xy - Print x, then y as many times as possible in the tab space
		-- trail - Character to show for trailing spaces
		-- extends - Character to show when 'wrap' is off and line extends off-screen
		-- precedes - Character to show when line extends left off screen
		-- nbsp - Character to show for a non-breakable space
		-- conceal - Character to show for concealed text when conceallevel is 1
		-- ]]]
		vim.cmd([[set listchars=tab:▷┅,trail:•,extends:»,precedes:«,nbsp:✖,conceal:≠]])
		-- ]]]

		-- Influence insert-mode completion
		vim.cmd([[set completeopt=longest,menu,menuone,preview,noinsert]])

		-- Open diffs in vertical splits
		vim.opt.diffopt:append({
			vertical = true,
		})

		-- Set characters for filling
		vim.cmd([[set fillchars=vert:┃,fold:\ ,diff:-,eob:\ ,msgsep:‾]])

		-- Set formatting options [[[
		-- t: Auto-wrap text using textwidth
		-- c: Auto-wrap comments using textwidth, and insert the comment leader
		-- q: Allow formatting comments with `gq`
		-- n: Recognize numbered lists when formatting
		-- m: Break at multibyte characters above 255
		-- M: Don't insert a space before/after multibyte characters
		-- 1: Break a line before a one-letter word instead of after
		-- j: Remove a comment leader when joining lines if it makes sense
		-- ]]]
		vim.cmd([[set formatoptions=tcqnmM1j]])

		-- Add matching pairs. % jumps between pairs
		vim.cmd([[set matchpairs+=<:>,「:」,『:』,【:】,“:”,‘:’,《:》,':',":"]])

		-- Use specific regional variations of English for spelling
		vim.cmd([[set spelllang=en_us,en_ca,en_gb]])

		-- Allow left/right arrows to go to the previous/next line
		vim.cmd("set whichwrap+=<,>,[,]")

		local py3_venv = vim.fn.stdpath('data') .. '/venv/bin/python3'
		if vim.fn.filereadable(py3_venv) then
			vim.g.python3_host_prog = py3_venv
		elseif vim.fn.executable('python3') then
			vim.g.python3_host_prog = vim.fn.resolve(vim.fn.exepath('python3'))
		else
			error('Python 3 not found')
		end

		if vim.fn.has('patch-8.1.1564') then
			vim.opt.signcolumn = "number"
		else
			vim.opt.signcolumn = "yes"
		end

		if vim.fn.executable("rg") then
			vim.opt.grepprg = "rg --vimgrep --no-heading --smart-case"
			vim.opt.grepformat = "%f:%l:%c:%m"
		elseif vim.fn.executable("ag") then
			vim.opt.grepprg = "ag --nogroup --nocolor"
		end

		for _, path in ipairs(settings_paths) do
			local settings = vim.fn.globpath(vim.o.runtimepath, path, 0, 1)
			for _, f in ipairs(settings) do
				vim.cmd("source " .. f)
			end
		end

		local xdg_config = os.getenv('XDG_CONFIG_HOME')
		if xdg_config == nil then
			xdg_config = os.getenv('HOME') .. '/.config'
		end

		if vim.fn.filereadable(xdg_config .. '/vim-local.vim') ~= 0 then
			vim.cmd('source ' .. xdg_config .. '/vim-local.vim')
		end

		if vim.fn.filereadable(xdg_config .. '/vim-local.lua') ~= 0 then
			vim.cmd('source ' .. xdg_config .. '/vim-local.lua')
		end
	end,
}

return config
