-- ==========================================================
-- Helpers
-- ==========================================================

local function select_all()
	-- `ggVG`, but nothing is added to jumplist, and cursor position is restored on exit from visual mode
	local bufnr = 0
	local end_line = vim.api.nvim_buf_line_count(bufnr)
	local curpos = vim.api.nvim_win_get_cursor(0)
	local view = vim.fn.winsaveview() -- persist cursor position relative to view

	vim.fn.setpos("'<", { bufnr, 1, 1, 0 })
	vim.fn.setpos("'>", { bufnr, end_line, 1000000, 0 })

	vim.cmd("normal! gv")

	vim.api.nvim_create_autocmd("ModeChanged", {
		pattern = { "v:n", "V:n", ":n" }, -- all visual → normal exits
		once = true,
		callback = function()
			vim.api.nvim_win_set_cursor(0, curpos)
			vim.fn.winrestview(view)
		end,
	})
end

-- ==========================================================
-- Mappings
-- ==========================================================

local set = vim.keymap.set

vim.g.mapleader = " "

-- General
set({ "n", "v", "i" }, "<C-a>", select_all, { desc = "select all" })

-- Copy & Paste
set({ "v", "n" }, "<C-c>", '"+y', { desc = "Yank to clipboard" })
set("n", "<C-c>", '"+Y', { desc = "Yank line to clipboard" })
set("v", "<C-x>", '"+ygv"_d', { desc = "Cut to clipboard" })
set("n", "<leader>p", '"+p', { desc = "paste from system clipboard" })
