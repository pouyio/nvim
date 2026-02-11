local f = require("plugins.common.utils")
return {
	{
		"zbirenbaum/copilot.lua",
		cmd = "Copilot",
		event = "InsertEnter",
		enabled = f.isMac(),
		opts = {
			copilot_node_command = vim.fn.expand("$VOLTA_HOME") .. "/tools/image/node/22.21.0/bin/node",
			suggestion = {
				auto_trigger = true,
				keymap = {
					accept = "<Tab>",
				},
			},
		},
		config = function(_, opts)
			require("copilot").setup(opts)
		end,
	},
}
