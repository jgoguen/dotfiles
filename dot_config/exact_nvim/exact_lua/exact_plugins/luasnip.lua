local M = {
	'L3MON4D3/LuaSnip',
	wants = 'friendly-snippets',
	module = 'luasnip',
}

function M.config()
	for _, load_type in ipairs {'vscode', 'snipmate', 'lua'} do
		local loader = require('luasnip.loaders.from_' .. load_type)
		loader.lazy_load()
	end
end

return M
