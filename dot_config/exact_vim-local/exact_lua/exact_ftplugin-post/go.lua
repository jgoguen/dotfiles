-- Do not edit this file directly! It is managed by chezmoi.

local M = {}

function M.setup()
	local MasonUtils = require('utils.mason')

	MasonUtils.ensure_installed('gopls')
end

return M
