local f = require("common.utils")

if f.isMac() then
	vim.pack.add({ "https://github.com/zbirenbaum/copilot.lua" })
	require("copilot").setup({
		copilot_node_command = vim.fn.expand("$VOLTA_HOME") .. "/tools/image/node/22.21.0/bin/node",
		suggestion = {
			auto_trigger = true,
			keymap = { accept = "<Tab>" },
		},
	})
end