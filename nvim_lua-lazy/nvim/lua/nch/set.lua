vim.opt.nu = true

-- indenting
vim.opt.tabstop=2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.wrap = false

--appearance 
vim.opt.termguicolors = true
vim.opt.relativenumber = true
vim.opt.colorcolumn = "80"
vim.opt.signcolumn = "yes"
vim.opt.scrolloff = 10
vim.opt.completeopt = "menuone,noinsert,noselect"

--behavior
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = k

vim.opt.smartcase = true
vim.opt.ignorecase = true

vim.opt.spell = true
--font
vim.opt.guifont="Hack_Nerd_Font_Mono:h11"


vim.opt.hlsearch = true
vim.opt.incsearch = true


vim.opt.updatetime = 50
