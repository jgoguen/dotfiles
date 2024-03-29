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
function M.comment_string()
	local commentstr = ''
	local HasTSComment, TSComment = pcall(require, 'ts_context_commentstring.internal')
	if HasTSComment then
		commentstr = TSComment.calculate_commentstring() or ''
	end

	if commentstr == '' then
		commentstr = vim.opt_local.commentstring:get()
	end

	local elems = vim.split(commentstr, '%s', {})
	if #elems == 0 or elems[1] == '' then
		return ''
	end

	return elems[1]
end

return M
