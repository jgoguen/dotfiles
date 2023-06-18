-- Do not edit this file directly! It is managed by chezmoi.

local Notify = require('utils.notify')

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
	vim_diagnostics_enabled = true,
}

-- Take the cmp source string or table and return a source table.
-- See nvim-cmp documentation for the format of the source table.
---@param source string|table
---@return table
function M.get_cmp_source(source)
	local cmp_src = type(source) == 'string' and { name = source } or source

	local priority = M.cmp_source_priority[cmp_src.name]
	if priority then
		cmp_src.priority = priority
	end

	---@cast cmp_src table
	return cmp_src
end

-- Takes a cmp source table and adds it to nvim-cmp
---@param source table
function M.add_cmp_source(source)
	local has_cmp, Cmp = pcall(require, 'cmp')
	if not has_cmp then return end

	local config = Cmp.get_config()
	table.insert(config.sources, source)

	Cmp.setup(config)
end

---@param name string
---@return string
function M.get_icon(name)
	local Icons = require('config.icons')
	return Icons[name] or ''
end

-- Disable the next diagnostic here for editing in chezmoi. In chezmoi both this file and the file in ~/.config/nvim
-- get loaded, which makes the LSP believe there's a duplicate alias when technically it's the same alias being loaded
-- twice.
---@diagnostic disable-next-line: duplicate-doc-alias
---@alias LSPKindMode
---| '"text"'
---| '"text_symbol"'
---| '"symbol_text"'
---| '"symbol"'
---@return {mode: LSPKindMode, symbol_map: table<string, string>}
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
			Null = 'NULL',
			Number = '#',
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

---@param mode string
---@param key string
---@param val string|fun()
---@param opts? table
function M.set_keymap(mode, key, val, opts)
	local options = { noremap = true, silent = true }
	if opts then
		options = vim.tbl_extend('force', options, opts)
	end

	vim.keymap.set(mode, key, val, options)
end

---@param mapping table
---@return table
function M.invert(mapping)
	local result = {}
	for k, v in pairs(mapping) do
		result[v] = k
	end
	return result
end

-- Opens a floating window
-- opts:
--	- width: int (0,1]: Percentage of the editor width for the window
--	- height: int (0,1]: Percentage of the editor height for the window
--	- border: Window border style (none, single, double, rounded, solid, shadow)
-- How to add content to the new window:
--	local buf = floating_window(opts)
--	vim.api.nvim_buf_set_lines(buf, 0, -1, true, <string content>)
--- @param opts {width?: number, height?: number, border?: string}
function M.floating_window(opts)
	local default_config = {
		width = 0.8,
		height = 0.8,
		border = 'rounded',
	}
	opts = vim.tbl_extend('force', default_config, opts)

	local total_width = vim.api.nvim_get_option("columns")
	local total_height = vim.api.nvim_get_option("lines")
	local win_width = opts.width <= 1 and math.ceil(total_width * opts.width) or total_width
	local win_height = opts.height <= 1 and math.ceil(total_height * opts.height) or total_height
	local win_opts = {
		relative = 'editor',
		width = win_width,
		height = win_height,
		row = math.ceil((total_height - win_height) / 2 - 1),
		col = math.ceil(total_width - win_width) / 2,
		focusable = true,
		style = 'minimal',
		border = opts.border,
	}
	local buf = vim.api.nvim_create_buf(false, true)

	vim.api.nvim_open_win(buf, true, win_opts)
	vim.api.nvim_win_set_option(0, "wrap", true)

	return buf
end

function M.close_floating_windows()
	local inactive_floating_windows = vim.fn.filter(
		vim.api.nvim_list_wins(),
		function(_, v)
			local ft = vim.api.nvim_buf_get_option(vim.api.nvim_win_get_buf(v), 'filetype')
			return vim.api.nvim_win_get_config(v).relative ~= ''
					and v ~= vim.api.nvim_get_current_win()
					and ft ~= 'hydra_hint'
		end
	)

	for _, win in ipairs(inactive_floating_windows) do
		pcall(vim.api.nvim_win_close, win, false)
	end
end

---@param opt string
---@param silent? boolean
---@param values? {[1]:any, [2]:any}
function M.toggle(opt, silent, values)
	if values then
		if vim.opt_local[opt]:get() == values[1] then
			vim.opt_local[opt] = values[2]
		else
			vim.opt_local[opt] = values[1]
		end

		if not silent then
			Notify.info(string.format('Set %s to %s', opt, vim.opt_local[opt]:get()), 'Option')
		end
		return
	end

	vim.opt_local[opt] = not vim.opt_local[opt]:get()
	if not silent then
		if vim.opt_local[opt]:get() then
			Notify.info(string.format('Enabled %s', opt), 'Option')
		else
			Notify.info(string.format('Disabled %s', opt), 'Option')
		end
	end
end

function M.toggle_diagnostics()
	M.vim_diagnostics_enabled = not M.vim_diagnostics_enabled

	if M.vim_diagnostics_enabled then
		vim.diagnostic.enable()
		Notify.info('Enabled diagnostics', 'Diagnostics')
	else
		vim.diagnostic.disable()
		Notify.info('Enabled diagnostics', 'Diagnostics')
	end
end

---@param tool string
---@return boolean
function M.has_tool(tool)
	return vim.fn.executable(tool) ~= 0
end

---@param name string
function M.augroup(name)
	return vim.api.nvim_create_augroup("jgoguen_" .. name, { clear = true })
end

---@return string
function M.comment_string()
	local has_ts_comment, ts_comment = pcall(require, 'ts_context_commentstring.internal')
	if not has_ts_comment then
		return ''
	end

	local elems = vim.split(
		ts_comment.calculate_commentstring({}) or '',
		'%s',
		{}
	)
	if #elems == 0 then
		return ''
	end

	return elems[1]
end

return M
