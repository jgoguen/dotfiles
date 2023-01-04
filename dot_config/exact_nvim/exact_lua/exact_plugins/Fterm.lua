local M = {
	'numToStr/FTerm.nvim',
	event = 'UIEnter',
}

function M.config()
	local has_fterm, fterm = pcall(require, 'FTerm')
	if not has_fterm then return end

	fterm.setup({
		auto_close = false,
		border = 'double',
	})
end

return M
