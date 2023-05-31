-- Do not edit this file directly! It is managed by chezmoi.

compiler tidy

nvim.keymap.set(
	'i',
	'=',
	function()
		local nodes_wanted = { 'attribute_name', 'directive_argument', 'directive_name' }
		local cursor_pos = vim.api.nvim_win_get_cursor(0)
		local cursor_range = { cursor_pos[1] - 1, cursor_pos[2] - 1 }
		local has_node, node = pcall(vim.treesitter.get_node, { pos = cursor_range })

		if has_node and node and vim.tbl_contains(nodes_wanted, node:type()) then
			return '=""<Left>'
		end
		return '='
	end,
	{ buffer = true, expr = true }
)
