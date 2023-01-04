return {
	settings = {
		redhat = {
			telemetry = {
				enabled = false,
			},
		},
		yaml = {
			customTags = {
				'!include_dir_named',
				'!lambda scalar',
				'!secret scalar',
			},
			format = {
				printWidth = 120,
				singleQuote = true,
			},
			schemas = {
				['http://json.schemastore.org/github-workflow'] = '.github/workflows/*.{yml,yaml}',
				['http://json.schemastore.org/github-action'] = '.github/action.{yml,yaml}',
				['http://json.schemastore.org/ansible-stable-2.9'] = 'roles/tasks/*.{yml,yaml},'
			},
		},
	},
}
