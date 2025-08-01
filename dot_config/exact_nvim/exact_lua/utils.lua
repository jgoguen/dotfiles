-- Do not edit this file directly! It is managed by chezmoi.

---@class Utils
---@field excluded_filetypes string[] Filetypes to exclude from certain operations
---@field excluded_buftypes string[] Buftypes to exclude from certain operations
---@field venv_paths string[] List of potential Python virtual environment directory names, relative to base_dirs
---@field base_dirs string[] List of base directories to search for Python virtual environments
---@field resolved_venv_dir string Resolved path to the Python virtual environment directory, if found
---@field debug_log_file string Path to the debug log file
---@field window_picker_opts table Options for window picker, including filter rules and hint style
---@field __log_queue string[] Queued log messages
---@field __flushing boolean Flag to indicate if the log is currently being flushed
local M = {
	excluded_filetypes = {
		'alpha',
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
	venv_paths = {
		'.venv',
		'venv',
		'env',
	},
	base_dirs = {
		LazyVim.root.get(),
		vim.fn.getcwd(),
		vim.fn.stdpath('data'),
	},
	resolved_venv_dir = '',
	debug_log_file = vim.fn.stdpath('cache') .. '/nvim-debug.log',
	__log_queue = {},
	__flushing = false,
}

M.window_picker_opts = {
	hint = 'floating-big-letter',
	filter_rules = {
		bo = {
			-- if the file type is one of following, the window will be ignored
			filetype = M.excluded_filetypes,
			-- if the buffer type is one of following, the window will be ignored
			buftype = M.excluded_buftypes,
		},
	},
	show_prompt = false,
}

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

---@param name string
function M.augroup(name)
	return vim.api.nvim_create_augroup('jgoguen_' .. name, { clear = true })
end

---@param tool string
---@return boolean
function M.has_tool(tool)
	return vim.fn.executable(tool) ~= 0
end

---@return string
function M.python_venv()
	if M.resolved_venv_dir ~= '' then
		return M.resolved_venv_dir
	end

	for _, base in ipairs(M.base_dirs) do
		for _, venv in ipairs(M.venv_paths) do
			local candidate_venv_dir = base .. '/' .. venv
			if vim.fn.isdirectory(candidate_venv_dir) == 1 then
				M.resolved_venv_dir = candidate_venv_dir
				return M.resolved_venv_dir
			end
		end
	end

	return ''
end

---@param binary string
---@return string
function M.python_venv_binary(binary)
	local candidate_venv_dir = M.python_venv()
	local candidate_path = candidate_venv_dir .. '/bin/' .. binary
	if vim.fn.filereadable(candidate_path) == 1 then
		return candidate_path
	end

	return ''
end

---@return string
function M.python_executable()
	local python3 = M.python_venv_binary('python3')
	if python3 ~= '' then
		return python3
	end

	return vim.fn.resolve(vim.fn.exepath('python3'))
end

function M.flush_debug_log()
	if M.__flushing or #M.__log_queue == 0 then
		return
	end
	M.__flushing = true

	local ok, f = pcall(io.open, M.debug_log_file, 'a')
	if not ok or not f then
		vim.notify('Failed to open debug log file: ' .. M.debug_log_file, vim.log.levels.ERROR)
		M.__log_queue = {}
		M.__flushing = false
		return
	end

	for _, msg in ipairs(M.__log_queue) do
		f:write(msg .. '\n')
	end
	f:close()

	M.__log_queue = {}
	M.__flushing = false
end

---@param fmt string Format string, printf-style
---@vararg ... any Arguments to format, converted to string with tostring()
function M.log(fmt, ...)
	if not vim.g.jgoguen_debug_log then
		return
	end

	local ok, msg = pcall(string.format, fmt, ...)
	if not ok then
		msg = ('<format error> %s | args=%s'):format(tostring(fmt), vim.inspect({ ... }))
	end

	table.insert(M.__log_queue, os.date('[%Y-%m-%d %H:%M:%S] ') .. msg)

	vim.defer_fn(function()
		M.flush_debug_log()
	end, 100)
end

return M
