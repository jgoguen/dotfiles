-- Do not edit this file directly! It is managed by chezmoi.

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

---@return boolean
function M.table_contains(haystack, needle)
	if type(haystack) ~= 'table' then
		return false
	end

	for _, value in ipairs(haystack) do
		if value == needle then
			return true
		end
	end

	return false
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

return M
