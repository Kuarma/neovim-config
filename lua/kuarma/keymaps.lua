local set = vim.keymap.set

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

vim.g.mapleader = " "

-- General
set({ "n", "v", "i" }, "<C-a>", select_all, { desc = "select all" })

--stylua: ignore start
set("n", "<leader>gD", vim.lsp.buf.declaration, { desc = "Declaration" })
set("n", "<leader>gt", vim.lsp.buf.type_definition, { desc = "Type Definition" })
set("n", "<leader>gr", vim.lsp.buf.references, { desc = "List references" })
set("n", "<C-e>n", function()	vim.diagnostic.jump({count=1, float=true}) end, {  desc = "Go to next error" })
set("n", "<C-e>p", function()	vim.diagnostic.jump({count=-1, float=true}) end, { desc = "Go to previous error" })
set("n", "K", vim.lsp.buf.hover, { desc = "Hover info" })
set("n", "<A-a>", function() vim.lsp.buf.code_action() end, { desc = "Code action" })
set("n", "gd", function()	vim.lsp.buf.definition() end, { desc = "Go to definition" })
set("n", "gI", function()	vim.lsp.buf.implementation() end, { desc = "Go to implementation" })
set("n", "<leader><leader>n", ":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>", { desc = "Substitute word in current buffer" })
set({ "n", "v" }, "<leader>r", function()	vim.lsp.buf.rename() end, { desc = "Global rename" })
--stylua: ignore end

-- Screenkeys
set("n", "<leader><Tab>", "<CMD>Screenkey<CR>", { desc = "Screenkey toggle" })

-- Oil
set({ "n", "v" }, "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })

-- Copy & Paste
set({ "v", "n" }, "<C-c>", '"+y', { desc = "Yank to clipboard" })
set("n", "<C-c>", '"+Y', { desc = "Yank line to clipboard" })
set("v", "<C-x>", '"+ygv"_d', { desc = "Cut to clipboard" })
set("n", "<leader>p", '"+p', { desc = "paste from system clipboard" })

-- Undotree
set("n", "<leader>u", "<Cmd>:UndotreeToggle<CR>", { desc = "Toggle Undotree" })

-- Quickfix
set("n", "<C-n>", "<cmd>cnext<cr>", { desc = "Quickfix: next" })
set("n", "<C-p>", "<cmd>cprevious<cr>", { desc = "Quickfix: previous" })

-- Tabs
set("n", "<A-h>", "<Esc>gT", { desc = "Tab prev" })
set("n", "<A-v>", "<Esc>g<Tab>", { desc = "Tab last visited" })
set("n", "<A-l>", "<Esc>gt", { desc = "Tab next" })
set("n", "<A-0>", "<Esc><cmd>tablast<cr>", { desc = "Tab last" })
set("n", "<leader>.", "<cmd>tabe .<cr>", { desc = "Open . in new tab" })
set("n", "<leader>,", "<cmd>tab sb<cr>", { desc = "Open current buffer in a new tab" })
set({ "i", "n" }, "<A-u>", "<Esc><cmd>tabmove -<cr>", { desc = "Tab move left" })
set({ "i", "n" }, "<A-y>", "<Esc><cmd>tabmove +<cr>", { desc = "Tab move right" })
set({ "i", "n" }, "<A-U>", "<Esc><cmd>tabmove 0<cr>", { desc = "Tab move first" })
set({ "i", "n" }, "<A-Y>", "<Esc><cmd>tabmove $<cr>", { desc = "Tab move last" })

for i = 1, 9 do
	set({ "n", "i" }, "<A-" .. i .. ">", "<Esc><cmd>tabn " .. i .. "<cr>", { desc = "Tab " .. i })
end

-- Jumps
set({ "i", "n" }, "<C-d>", "<C-d>zz", { desc = "Page down (centered)" })
set({ "i", "n" }, "<C-u>", "<C-u>zz", { desc = "Page up (centered)" })

-- Move line
set("v", "<A-j>", ":m '>+1<cr>gv=gv", { desc = "Move line down" })
set("v", "<A-k>", ":m '<-2<cr>gv=gv", { desc = "Move line up" })
set("n", "<A-j>", "V:m '>+1<cr>gv=gv", { desc = "Move line down" })
set("n", "<A-k>", "V:m '>-2<cr>gv=gv", { desc = "Move line up" })
set("i", "<A-j>", "<Esc>V:m '>+1<cr>gv=gv", { desc = "Move line down" })
set("i", "<A-k>", "<Esc>V:m '>-2<cr>gv=gv", { desc = "Move line up" })

-- Windows
set("n", "<C-w>h", "<cmd>wincmd H<cr>", { desc = "windows: move window left" })
set("n", "<C-w>j", "<cmd>wincmd J<cr>", { desc = "windows: move window down" })
set("n", "<C-w>k", "<cmd>wincmd K<cr>", { desc = "windows: move window up" })
set("n", "<C-w>l", "<cmd>wincmd L<cr>", { desc = "windows: move window right" })

set("n", "<C-w>o", "<C-w><C-s><C-w>w", { desc = "windows: new horizontal" })
set("n", "<C-w>O", "<C-w><C-v>", { desc = "windows: new vertical" })

set("n", "<C-Right>", "<cmd>vertical resize -2<cr>", { desc = "windows: decrease width" })
set("n", "<C-Left>", "<cmd>vertical resize +2<cr>", { desc = "windows: increase width" })
set("n", "<C-Down>", "<cmd>resize +2<cr>", { desc = "windows: decrease height" })
set("n", "<C-Up>", "<cmd>resize -2<cr>", { desc = "windows: increase height" })

-- Lua
set("v", "<leader><leader>lx", ":lua<CR>", { desc = "Lua: Run sleected lua code" })
