local M = {}

local function is_git_buffer(bufnr)
	local bufname = vim.api.nvim_buf_get_name(bufnr)
	local path = bufname ~= '' and vim.fs.dirname(bufname) or vim.uv.cwd()
	return vim.fs.find('.git', { path = path, upward = true })[1] ~= nil
end

local function client_supports_range_formatting(client)
	return client.server_capabilities.documentRangeFormattingProvider
		and client:supports_method('textDocument/rangeFormatting')
end

local function client_matches_filetype(client, filetype)
	local filetypes = client.config and client.config.filetypes
	return filetypes == nil or vim.tbl_contains(filetypes, filetype)
end

---@param bufnr integer
---@return vim.lsp.Client?
function M.get_range_format_client(bufnr)
	local filetype = vim.bo[bufnr].filetype

	for _, client in ipairs(vim.lsp.get_clients({ bufnr = bufnr })) do
		if client_supports_range_formatting(client) and client_matches_filetype(client, filetype) then
			return client
		end
	end

	return nil
end

---@param opts conform.FormatOpts
local function conform_format(opts)
	require('conform').format(vim.tbl_extend('force', {
		async = false,
		undojoin = true,
	}, opts))
end

---@param bufnr integer
---@return string[]
local function get_conform_range_formatters(bufnr)
	local ok, conform = pcall(require, 'conform')
	if not ok then
		return {}
	end

	local formatters = conform.list_formatters_to_run(bufnr)
	local range_formatters = {}

	for _, formatter in ipairs(formatters) do
		local config = conform.get_formatter_config(formatter.name, bufnr)
		if config and config.range_args then
			table.insert(range_formatters, formatter.name)
		end
	end

	return range_formatters
end

---@param formatters string[]
---@return fun(opts: conform.FormatOpts)
local function conform_range_format(formatters)
	return function(opts)
		conform_format(vim.tbl_extend('force', {
			formatters = formatters,
			lsp_format = 'never',
		}, opts))
	end
end

---@param bufnr integer
---@param formatters string[]
---@return vim.lsp.Client
local function conform_range_client(bufnr, formatters)
	return {
		id = -1,
		name = 'conform.nvim (' .. table.concat(formatters, ', ') .. ')',
		server_capabilities = {
			documentRangeFormattingProvider = true,
		},
		config = {
			filetypes = { vim.bo[bufnr].filetype },
		},
		supports_method = function(_, method)
			return method == 'textDocument/rangeFormatting'
		end,
	}
end

---@param client vim.lsp.Client
---@param bufnr integer
---@param format_callback? fun(opts: conform.FormatOpts)
---@return boolean
local function format_modified_regions_with_client(client, bufnr, format_callback)
	local ok, format_modifications = pcall(require, 'lsp-format-modifications')
	if not ok then
		return false
	end

	local opts = {
		experimental_empty_line_handling = vim.bo[bufnr].filetype == 'lua',
	}
	if format_callback then
		opts.format_callback = format_callback
	end

	local result = format_modifications.format_modifications(client, bufnr, opts)

	return result ~= nil and result.success == true
end

---@param bufnr integer
---@return boolean
function M.format_modified_regions(bufnr)
	if not is_git_buffer(bufnr) then
		return false
	end

	local client = M.get_range_format_client(bufnr)
	if client ~= nil then
		return format_modified_regions_with_client(client, bufnr)
	end

	local conform_range_formatters = get_conform_range_formatters(bufnr)
	if #conform_range_formatters == 0 then
		return false
	end

	return format_modified_regions_with_client(
		conform_range_client(bufnr, conform_range_formatters),
		bufnr,
		conform_range_format(conform_range_formatters)
	)
end

---@param bufnr integer
function M.format_on_save(bufnr)
	if not M.format_modified_regions(bufnr) then
		conform_format({ bufnr = bufnr })
	end
end

return M
