local M = {
	'rcarriga/nvim-notify',
	module = 'notify',
}

function M.config()
	local notify = require('notify')

	notify.setup({
		stages = 'fade',
	})

	vim.notify = notify
end

return M
