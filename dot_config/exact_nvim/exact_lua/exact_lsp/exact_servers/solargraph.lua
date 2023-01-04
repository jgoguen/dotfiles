local has_util, util = pcall(require, 'lspconfig.util')
local options = {
  filetypes = {
		'ruby', 'ruby.eruby.chef',
	},
}

if has_util then
  options['root_dir'] = util.root_pattern('.hg', '.git', 'cookbooks')
end

return options
