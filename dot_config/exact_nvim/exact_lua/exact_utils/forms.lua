-- Do not edit this file directly! It is managed by chezmoi.

local M = {
	link_formats = {
		default = '[%s](%s)',
		html = '<a href="%s">%s</a>',
		norg = '{%s}[%s]',
	},
}

function M.insert_link_with_text()
	local n = require('nui-components')
	local renderer = n.create_renderer({
		width = 60,
		height = 8,
	})

	local body = function()
		return n.form(
			{
				id = 'link-form',
				submit_key = '<CR>',
				on_submit = function(is_valid)
					if not is_valid then
						return
					end

					local url = renderer:get_component_by_id('link-url'):get_current_value()
					local text = renderer:get_component_by_id('link-text'):get_current_value()
					renderer:close()
					local row, col = unpack(vim.api.nvim_win_get_cursor(0))
					local style = vim.opt_local.filetype:get()

					local link_str = ''
					if style == 'norg' then
						link_str = string.format(M.link_formats['norg'], url, text)
					elseif style == 'html' then
						link_str = string.format(M.link_formats['html'], url, text)
					else
						link_str = string.format(M.link_formats['default'], text, url)
					end

					vim.api.nvim_buf_set_text(0, row - 1, col, row - 1, col, { link_str })
					vim.api.nvim_win_set_cursor(0, { row, col + string.len(link_str) })
				end,
			},
			n.text_input({
				id = 'link-url',
				autofocus = true,
				autoresize = true,
				size = 1,
				max_lines = 1,
				border_label = 'URL',
				validate = n.validator.is_not_empty,
			}),
			n.text_input({
				id = 'link-text',
				autoresize = true,
				size = 1,
				max_lines = 1,
				border_label = 'Link text',
				validate = n.validator.is_not_empty,
			})
		)
	end

	renderer:render(body)
end

return M
