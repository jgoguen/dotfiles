local present, cmp = pcall(require, 'cmp')
if not present then
	return {}
end

return {
	cmdline = {
		["/"] = {
			sources = {
				{ name = 'buffer' },
			},
		},
		[":"] = {
			sources = cmp.config.sources({
				{ name = 'path' },
			}, {
				{ name = 'cmdline' },
			})
		},
	},
}
