local utils = require("kuarma.utils")

local opt = vim.opt

opt.number = true
opt.relativenumber = false

opt.spell = true
opt.spelllang = "en_us"
opt.spelloptions = "camel"
opt.spellfile = os.getenv("HOME") .. "/.config/nvim/spell/en.utf-8.add"

vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"

opt.more = true

opt.wrap = false
opt.linebreak = true
opt.ruler = false

opt.termguicolors = true
opt.cursorline = true
opt.culopt = "both"

opt.splitbelow = true
opt.splitright = true

opt.splitkeep = "screen"

opt.swapfile = false

opt.signcolumn = "yes:2"
opt.isfname:append("@-@")
opt.shada = { "'10", "<0", "s10", "h" }

opt.guicursor =
	"n:blinkwait3000-blinkoff50-blinkon400-Cursor/lCursor,i:ver40-blinkwait3000-blinkoff300-blinkon150-Cursor/lCursor,c:ver40-blinkwait3000-blinkoff300-blinkon150-Cursor/lCursor"

opt.history = 500

opt.backup = false
opt.undodir = os.getenv("HOME") .. "/.vim/undodir"

local undoDir = vim.fn.expand(vim.o.undodir)
if not vim.fn.isdirectory(undoDir) then
	utils.create_dir(undoDir)
end

opt.fillchars = { fold = " " }
opt.foldmethod = "indent"
opt.foldenable = false
opt.foldlevel = 99

opt.tabstop = 2
opt.softtabstop = 2
opt.shiftwidth = 2
opt.expandtab = true

opt.ignorecase = true
opt.smartcase = true

opt.fileencoding = "utf-8"
opt.fileencodings = { "ucs-bom", "utf-8", "cp936", "gb18030", "big5", "euc-jp", "euc-kr", "latin1" }

opt.scrolloff = 3

opt.mouse = "n"
opt.mousemodel = "popup"
opt.mousescroll = { "ver:1", "hor:0" }

opt.showmode = false

opt.fileformats = { "unix", "dos" }
opt.confirm = true

opt.autowrite = false
opt.autoread = true

opt.showcmdloc = "statusline"
