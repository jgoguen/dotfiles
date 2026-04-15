local M = {}

local function normalize_python_include(path)
	path = path:gsub('^(%.%.)%.*', function(match)
		return match:sub(1, 2) .. '/' .. string.rep('../', #match - 2)
	end)
	path = path:gsub('^%.([^%.])', './%1')
	path = path:gsub('(%w)%.(%w)', '%1/%2')
	return path
end

local function find_python_target(path)
	return vim.fn.findfile(path) ~= '' or vim.fn.findfile(path .. '/__init__.py') ~= ''
end

function M.python_includeexpr(fname)
	local import_line = vim.split(fname, ' import ', { plain = true, trimempty = true })
	local base = normalize_python_include(import_line[1] or fname)

	if #import_line > 1 and import_line[2] ~= '' then
		local candidate = normalize_python_include(base .. '.' .. import_line[2])
		if find_python_target(candidate) then
			return candidate
		end
	end

	return base
end

return M
