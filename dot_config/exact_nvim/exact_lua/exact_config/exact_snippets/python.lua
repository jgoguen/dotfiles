-- Do not edit this file directly! It is managed by chezmoi.

local Luasnip = require('luasnip')
local Format = require('luasnip.extras.fmt').fmt

return {
	Luasnip.snippet(
		'ifmain',
		Format(
			[[def main() -> int:
    {}

if __name__ == "__main__":
    main()]],
			{ Luasnip.insert_node(1) }
		)
	),
	Luasnip.snippet(
		'with',
		Format(
			[[
{} {} as {}:
	{}]],
			{
				Luasnip.choice_node(1, { Luasnip.text_node('with'), Luasnip.text_node('async with') }),
				Luasnip.insert_node(2, 'expr'),
				Luasnip.insert_node(3, 'var'),
				Luasnip.insert_node(0),
			}
		)
	),
}
