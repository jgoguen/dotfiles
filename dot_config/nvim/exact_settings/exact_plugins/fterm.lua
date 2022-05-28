local present, fterm = pcall(require, 'FTerm')
if not present then
	return
end

fterm.setup({
	auto_close = false,
	border = "double",
})

vim.keymap.set('n', '<C-t>', '<CMD>lua require("FTerm").toggle()<CR>')
vim.keymap.set('t', '<C-t>', '<C-\\><C-n><CMD>lua require("FTerm").toggle()<CR>')
