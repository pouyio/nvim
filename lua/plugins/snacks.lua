local f = require("plugins.common.utils")

-- Function to check clipboard with retries
local function getRelativeFilepath(retries, delay, callback)
	local function tryGetFilepath(remaining_retries)
		local relative_filepath = vim.fn.getreg("+")
		if relative_filepath ~= "" then
			callback(relative_filepath) -- Call the callback with the filepath if found
		elseif remaining_retries > 1 then
			vim.defer_fn(function()
				tryGetFilepath(remaining_retries - 1)
			end, delay)
		else
			callback(nil) -- Call the callback with nil if retries are exhausted
		end
	end

	tryGetFilepath(retries)
end

-- Function to handle editing from Lazygit
function LazygitEdit(original_buffer)
	local current_bufnr = vim.fn.bufnr("%")
	local channel_id = vim.fn.getbufvar(current_bufnr, "terminal_job_id")

	if not channel_id then
		vim.notify("No terminal job ID found.", vim.log.levels.ERROR)
		return
	end

	vim.fn.chansend(channel_id, "\15") -- \15 is <c-o> to copy path

	getRelativeFilepath(5, 50, function(relative_filepath)
		if not relative_filepath then
			vim.notify("Clipboard is empty or invalid.", vim.log.levels.ERROR)
			return
		end

		local winid = vim.fn.bufwinid(original_buffer)

		if winid == -1 then
			vim.notify("Could not find the original window.", vim.log.levels.ERROR)
			return
		end

		Snacks.lazygit()
		vim.fn.win_gotoid(winid)
		vim.cmd("edit " .. vim.fn.fnameescape(relative_filepath))
	end)
end

local global_keys = {
	["s"] = "edit_vsplit",
	["t"] = "tab",
	["<Down>"] = {
		"history_forward",
		mode = "i",
	},
	["<Up>"] = {
		"history_back",
		mode = "i",
	},
	[f.isMac() and "<D-f>" or "<C-f>"] = "qflist",
	["<C-d>"] = { "preview_scroll_down", mode = { "n", "i" } },
	["<C-u>"] = { "preview_scroll_up", mode = { "n", "i" } },
	["<leader>a"] = "add_to_harpoon",
}

local buffer_keys = {
	["<leader>w"] = "bufdelete",
	["v"] = "list_down",
	["c"] = "list_up",
}

return {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,
	opts = {
		words = {
			debounce = 50,
			enabled = true,
			notify_jump = true,
		},
		lazygit = {
			win = {
				height = 0.95,
				width = 0.95,
				keys = {
					{
						f.isMac() and "<D-l>" or "<C-l>",
						function()
							Snacks.lazygit()
						end,
						mode = "t",
					},
				},
			},
		},
		terminal = {
			win = {
				height = 0.95,
				width = 0.95,
			},
		},
		picker = {
			actions = {
				add_to_harpoon = function(picker)
					local harpoon = require("harpoon")
					local full_path = picker:current()
					local cwd_path = picker:cwd()

					local item = {
						value = full_path.file:gsub("^" .. vim.pesc(cwd_path) .. "/", ""),
						context = {
							row = 1,
							col = 0,
						},
					}
					harpoon:list():add(item)
				end,
			},
			formatters = {
				file = {
					filename_first = true,
				},
			},
			win = {
				input = {
					keys = global_keys,
				},
				list = {
					keys = global_keys,
				},
			},
			sources = {
				buffers = {
					focus = "list",
					win = {
						input = {
							keys = buffer_keys,
						},
						list = {
							keys = buffer_keys,
						},
					},
				},
				grep = {
					args = {
						"--hidden",
						"-i",
					},
				},
				files = {
					cmd = "rg",
					args = {
						"--files", -- Search for files
						"--hidden", -- Include hidden files and directories
						"--iglob",
						"!.git", -- Exclude the .git directory
					},
				},
				select = {
					focus = "list",
					layout = {
						preset = "select",
					},
				},
				lsp_references = {
					focus = "list",
				},
			},
		},
	},
	keys = {
		{
			f.isMac() and "<D-l>" or "<C-l>",
			function()
				local current_buffer = vim.api.nvim_get_current_buf()
				Snacks.lazygit()

				-- keymap to open file and close lazygit
				vim.keymap.set("t", f.isMac() and "<D-o>" or "<C-o>", function()
					LazygitEdit(current_buffer)
				end, { buffer = true, noremap = true, silent = true })
			end,
			mode = "n",
			desc = "Open Lazygit",
		},
		{
			f.isMac() and "<D-j>" or "<C-j>",
			function()
				Snacks.terminal("zsh")
			end,
			desc = "Open Terminal",
		},
		{
			f.isMac() and "<D-j>" or "<C-j>",
			function()
				Snacks.terminal.toggle("zsh")
			end,
			mode = "t",
			desc = "Toggle Terminal when opened",
		},
		{
			"<A-n>",
			function()
				Snacks.words.jump(1, true)
			end,
			desc = "Next occurence",
		},
		{
			"<A-p>",
			function()
				Snacks.words.jump(-1, true)
			end,
			desc = "Prev occurence",
		},
		{
			"<leader>v",
			function()
				Snacks.picker.buffers({
					on_show = function(picker)
						-- start in the next buffer
						picker:action("list_down")
					end,
				})
			end,
		},
		{
			"<leader>p",
			function()
				Snacks.picker.files()
			end,
		},
		{
			"<leader>ff",
			function()
				Snacks.picker.grep()
			end,
			mode = "n",
		},
		{
			"<leader>ff",
			function()
				Snacks.picker.grep_word({
					focus = "list",
				})
			end,
			mode = "v",
		},
		{
			"<leader>fr",
			function()
				Snacks.picker.resume()
			end,
		},
		{
			"gr",
			function()
				Snacks.picker.lsp_references()
			end,
		},
	},
	config = function(_, opts)
		local custom_default = vim.deepcopy(require("snacks.picker.config.layouts").default)
		custom_default.layout.width = 0.95
		custom_default.layout.height = 0.9
		custom_default.layout[2].min_width = 85
		custom_default.layout[2].width = 85

		local custom_vertical = vim.deepcopy(require("snacks.picker.config.layouts").vertical)
		custom_vertical.layout.height = 0.95
		custom_vertical.layout.backdrop = true
		custom_vertical.layout.width = 0.8
		custom_vertical.layout[3].height = 0.8

		opts.picker.layout = custom_default
		opts.picker.sources.select.layout = require("snacks.picker.config.layouts").select
		opts.picker.sources.buffers.layout = custom_vertical

		require("snacks").setup(opts)
	end,
}
