local M = {}

local function get_all_marks()
	local marks_output = vim.fn.execute("marks")
	local global_marks = {}

	for line in marks_output:gmatch("[^\r\n]+") do
		local mark_char, line_num = line:match("^%s*(%u)%s+(%d+)")

		if mark_char then
			local pos = vim.fn.getpos("'" .. mark_char)
			local file = ""
			if pos[1] ~= 0 then
				file = vim.fn.bufname(pos[1])
				if file == "" then
					file = vim.api.nvim_buf_get_name(pos[1])
				end
				-- Normalize to relative path from project root
				if file ~= "" then
					file = vim.fn.fnamemodify(file, ":~:.")
				end
			end

			table.insert(global_marks, {
				mark = mark_char,
				line = tonumber(line_num),
				file = file,
			})
		end
	end

	return global_marks
end

function M.go_to_global_mark()
	local char = vim.fn.getcharstr()

	local ok, err = pcall(function()
		vim.cmd("normal! `" .. string.upper(char))
	end)
	if not ok then
		print(err)
	end
end

function M.delete_line_marks()
	local bufnr = vim.api.nvim_get_current_buf()
	local cur_line = vim.fn.line(".")

	---@type { mark: string, pos: number[] }[]
	local all_marks_local = vim.fn.getmarklist(bufnr)
	for _, mark in ipairs(all_marks_local) do
		if mark.pos[2] == cur_line and string.match(mark.mark, "'[a-z]") then
			vim.notify("Deleting mark: " .. string.sub(mark.mark, 2, 2))
			vim.api.nvim_buf_del_mark(bufnr, string.sub(mark.mark, 2, 2))
		end
	end
	local bufname = vim.api.nvim_buf_get_name(bufnr)

	---@type { file: string, mark: string, pos: number[] }[]
	local all_marks_global = vim.fn.getmarklist()
	for _, mark in ipairs(all_marks_global) do
		local expanded_file_name = vim.fn.fnamemodify(mark.file, ":p")
		if bufname == expanded_file_name and mark.pos[2] == cur_line and string.match(mark.mark, "'[A-Z]") then
			vim.notify("Deleting mark: " .. string.sub(mark.mark, 2, 2))
			vim.api.nvim_del_mark(string.sub(mark.mark, 2, 2))
		end
	end
end

function M.open_marks_list()
	local marks = get_all_marks()
	local buf = vim.api.nvim_create_buf(false, true)

	vim.api.nvim_set_option_value("buftype", "nofile", { buf = buf })
	vim.api.nvim_set_option_value("bufhidden", "wipe", { buf = buf })
	vim.api.nvim_set_option_value("buflisted", false, { buf = buf })

	local lines = {}
	if #marks == 0 then
		lines = { "No marks set" }
	else
		for _, mark in ipairs(marks) do
			local display = mark.file ~= "" and mark.file or "[No File]"
			table.insert(lines, string.format("%s  %s:%d", mark.mark, display, mark.line))
		end
	end

	vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
	vim.api.nvim_set_option_value("modifiable", false, { buf = buf })

	local width = math.floor(vim.o.columns * 0.7)
	local height = math.min(#lines + 2, math.floor(vim.o.lines * 0.5))

	local win = vim.api.nvim_open_win(buf, true, {
		relative = "editor",
		width = width,
		height = height,
		row = math.floor((vim.o.lines - height) / 2 - 1),
		col = math.floor((vim.o.columns - width) / 2),
		border = "rounded",
		title = " Marks ",
		title_pos = "left",
		style = "minimal",
	})

	vim.api.nvim_set_option_value("wrap", false, { win = win })

	-- Highlight mark letters
	vim.api.nvim_set_hl(0, "MarksListMark", { fg = "#f38ba8" })
	local ns = vim.api.nvim_create_namespace("marks_list")
	for i = 0, #lines - 1 do
		if lines[i + 1] ~= "No marks set" then
			vim.api.nvim_buf_set_extmark(buf, ns, i, 0, { end_col = 1, hl_group = "MarksListMark" })
		end
	end

	local function close()
		if vim.api.nvim_win_is_valid(win) then
			vim.api.nvim_win_close(win, true)
		end
	end

	local function delete_mark()
		local line = vim.api.nvim_buf_get_lines(
			buf,
			vim.api.nvim_win_get_cursor(win)[1] - 1,
			vim.api.nvim_win_get_cursor(win)[1],
			false
		)[1]
		local mark = line:match("^(%u)")
		if mark then
			vim.cmd("delmarks " .. mark)
			close()
			M.open_marks_list()
		end
	end

	local function jump_to_mark()
		local line = vim.api.nvim_buf_get_lines(
			buf,
			vim.api.nvim_win_get_cursor(win)[1] - 1,
			vim.api.nvim_win_get_cursor(win)[1],
			false
		)[1]
		local mark = line:match("^(%u)")
		if mark then
			close()
			pcall(function()
				vim.cmd("normal! `" .. mark)
			end)
		end
	end

	vim.keymap.set("n", "dd", delete_mark, { buffer = buf, nowait = true, silent = true })
	vim.keymap.set("n", "<CR>", jump_to_mark, { buffer = buf, nowait = true, silent = true })
	vim.keymap.set("n", "q", close, { buffer = buf, nowait = true, silent = true })
	vim.keymap.set("n", "<Esc>", close, { buffer = buf, nowait = true, silent = true })
end

return M
