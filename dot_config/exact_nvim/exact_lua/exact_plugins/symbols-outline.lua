local M = {
	'simrat39/symbols-outline.nvim',
}

function M.config()
	local utils = require('jgoguen.utils')

	require('symbols-outline').setup({
		symbols = {
			File = {icon = utils.get_icon('DefaultFile')},
			Namespace = {icon = utils.get_icon('Array')},
			Package = {icon = utils.get_icon('Package')},
			Class = {icon = utils.get_icon('Class')},
			Method = {icon = utils.get_icon('Function')},
			Property = {icon = utils.get_icon('Setting')},
			Constructor = {icon = utils.get_icon('Build')},
			Enum = {icon = utils.get_icon('Enum')},
			Interface = {icon = utils.get_icon('Interface')},
			Function = {icon = utils.get_icon('Function')},
			String = {icon = utils.get_icon('Font')},
			Array = {icon = utils.get_icon('Array')},
			Key = {icon = utils.get_icon('Key')},
		},
	})
end

return M
