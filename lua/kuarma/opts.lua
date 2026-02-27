-----------------------------------------------------------
-- Neovim options
-----------------------------------------------------------
local opt = vim.opt

opt.inccommand = "split"

opt.guicursor =
	"n:blinkwait3000-blinkoff50-blinkon400-Cursor/lCursor,i:ver40-blinkwait3000-blinkoff300-blinkon150-Cursor/lCursor,c:ver40-blinkwait3000-blinkoff300-blinkon150-Cursor/lCursor"

opt.nu = true
--o.relativenumber = true

opt.backup = false
opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
--Ensure dir is created
if not vim.fn.isdirectory(vim.fn.expand(vim.o.undodir)) then
	vim.fn.mkdir(vim.fn.expand(opt.undodir), "p", "0770")
end

opt.termguicolors = true
opt.cursorline = true
opt.culopt = "number"

opt.smartcase = true
opt.hlsearch = false
opt.ignorecase = true

opt.splitbelow = true
opt.splitright = true
opt.showmode = false
opt.winminwidth = 5

opt.signcolumn = "yes"
opt.isfname:append("@-@")
opt.shada = { "'10", "<0", "s10", "h" }

opt.swapfile = false

opt.wrap = true
opt.linebreak = true

opt.joinspaces = false

opt.tabstop = 4
opt.shiftwidth = 4

opt.more = false

opt.title = true
opt.titlestring = '%t%( %M%)%( (%{expand("%:~:h")})%)%a (nvim)'

opt.undofile = true

-- Make :wa not ask for confirmation (skip unwritable buffers silently)
vim.api.nvim_create_user_command("Wa", "silent! wa", {})
vim.cmd.cnoreabbrev("wa", "Wa")
