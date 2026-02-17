local f = require("plugins.common.utils")

vim.o.clipboard = "unnamedplus" -- Enables system clipboard integration; yanked text will be available in the system clipboard
vim.o.expandtab = true -- Converts tabs to spaces when you input them
vim.o.ignorecase = true -- Makes search operations case-insensitive
vim.o.linebreak = true -- Wraps long lines at the edge of the screen instead of breaking words
vim.o.backup = false -- Disables the creation of backup files
vim.o.swapfile = false -- Disables the creation of swap files
vim.o.undodir = os.getenv("HOME") .. "/.vim/undodir" -- directory to store undo list
vim.o.undofile = true -- enable saving undo
vim.o.number = true -- Displays absolute number in selected line
vim.o.relativenumber = true -- Displays relative line numbers
vim.o.shiftwidth = 2 -- Sets the number of spaces for each level of indentation when using the ">" and "<" commands
vim.o.softtabstop = 2 -- Defines the number of spaces to insert for a <Tab> key
vim.o.tabstop = 2 -- Sets the number of spaces a <Tab> character counts for
vim.o.splitright = true -- Opens new vertical splits to the right of the current split
vim.o.timeoutlen = 500 -- Sets the time in milliseconds to wait for key codes
vim.o.ttimeoutlen = 0 -- Disables the time Neovim waits for a key code
vim.wo.scl = "yes" -- Sets "sidescrolloff" to "yes," making the cursor stay a certain number of columns away from the screen edge when scrolling horizontally
vim.o.scrolloff = 20 -- Specifies the minimum number of screen lines to keep above and below the cursor
vim.o.pumheight = 10 -- Sets the maximum height of the popup menu
vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions,globals" -- recomended for plugin auto-session
vim.filetype.add({
	extension = {
		mdx = "mdx",
	},
})
vim.o.mousescroll = f.isMac() and "ver:1,hor:1" or "ver:3,hor:3"
vim.o.winborder = "rounded"

-- Reserve a space in the gutter
-- This will avoid an annoying layout shift in the screen
vim.opt.signcolumn = "yes"

vim.diagnostic.config({
	virtual_text = true,
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = f.diagnosticIcons.ERROR,
			[vim.diagnostic.severity.WARN] = f.diagnosticIcons.WARN,
			[vim.diagnostic.severity.INFO] = f.diagnosticIcons.INFO,
			[vim.diagnostic.severity.HINT] = f.diagnosticIcons.HINT,
		},
	},
})

vim.o.foldmethod = "indent"
vim.o.foldlevelstart = 99
