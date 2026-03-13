-- ==========================================================
-- Mappings
-- ==========================================================

local set = vim.keymap.set

vim.g.mapleader = " "

-- Copy & Paste
set({ "v", "n" }, "<C-c>", '"+y', { desc = "Yank to clipboard" })
set("n", "<C-c>", '"+Y', { desc = "Yank line to clipboard" })
set("v", "<C-x>", '"+ygv"_d', { desc = "Cut to clipboard" })
set("n", "<leader>p", '"+p', { desc = "paste from system clipboard" })

set("n", "q", "q", { noremap = true, silent = false })


-- LSP
--stylua: ignore start
set("n", "<leader>gD", vim.lsp.buf.declaration, { desc = "Declaration" })
set("n", "<leader>gt", vim.lsp.buf.type_definition, { desc = "Type Definition" })
set("n", "<leader>gr", vim.lsp.buf.references, { desc = "List references" })
set("n", "<A-e>n", function()	vim.diagnostic.jump({count=1, float=true}) end, {  desc = "Go to next diagnostic" })
set("n", "<A-e>p", function()	vim.diagnostic.jump({count=-1, float=true}) end, { desc = "Go to previous diagnostic" })
set("n", "<A-a>", function() vim.lsp.buf.code_action() end, { desc = "Code action" })
set("n", "gd", function()	vim.lsp.buf.definition() end, { desc = "Go to definition" })
set("n", "gI", function()	vim.lsp.buf.implementation() end, { desc = "Go to implementation" })
set("n", "<leader><leader>n", ":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>", { desc = "Substitute word in current buffer" })
set({ "n", "v" }, "<leader>r", function()	vim.lsp.buf.rename() end, { desc = "Global rename" })
set({ "n", "v" }, ".", "<cmd>b#<cr>", { desc = "Go back to last opened buffer" })
--stylua: ignore end

-- Screenkeys
set("n", "<leader><Tab>", "<CMD>Screenkey<CR>", { desc = "Screenkey toggle" })

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

-- Move line
set("v", "<A-j>", ":m '>+1<cr>gv=gv", { desc = "Move line down" })
set("v", "<A-k>", ":m '<-2<cr>gv=gv", { desc = "Move line up" })
set("n", "<A-j>", "V:m '>+1<cr>gv=gv", { desc = "Move line down" })
set("n", "<A-k>", "V:m '>-2<cr>gv=gv", { desc = "Move line up" })
set("i", "<A-j>", "<Esc>V:m '>+1<cr>gv=gv", { desc = "Move line down" })
set("i", "<A-k>", "<Esc>V:m '>-2<cr>gv=gv", { desc = "Move line up" })

for i = 1, 9 do
	set({ "n", "i" }, "<A-" .. i .. ">", "<Esc><cmd>tabn " .. i .. "<cr>", { desc = "Tab " .. i })
end

-- Window movement
set("n", "<C-w>h", "<cmd>wincmd H<cr>", { desc = "window: move window left" })
set("n", "<C-w>j", "<cmd>wincmd J<cr>", { desc = "window: move window down" })
set("n", "<C-w>k", "<cmd>wincmd K<cr>", { desc = "window: move window up" })
set("n", "<C-w>l", "<cmd>wincmd L<cr>", { desc = "window: move window right" })

set("n", "<C-w>o", "<C-w><C-s><C-w>w", { desc = "window: new horizontal" })
set("n", "<C-w>O", "<C-w><C-v>", { desc = "window: new vertical" })

set("n", "<C-Right>", "<cmd>vertical resize -2<cr>", { desc = "window: decrease width" })
set("n", "<C-Left>", "<cmd>vertical resize +2<cr>", { desc = "window: increase width" })
set("n", "<C-Down>", "<cmd>resize +2<cr>", { desc = "window: decrease height" })
set("n", "<C-Up>", "<cmd>resize -2<cr>", { desc = "window: increase height" })

-- Lua
set("v", "<leader><leader>x", ":lua<CR>", { desc = "Lua: Run sleected lua code" })
