local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end

vim.opt.rtp:prepend(lazypath)

-- disable netrw
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

require("lazy").setup({
	{ "LazyVim/LazyVim" },
	{ import = "plugins" },
	--	{ import = "lazyvim.plugins.extras.dap.core" },
	{ "airblade/vim-gitgutter" }, -- git gutter icons
	{ "vim-airline/vim-airline" }, -- show current branch
	{ "lukas-reineke/indent-blankline.nvim", main = "ibl", opts = {} }, -- line indenting
	{ "tpope/vim-sleuth" }, -- auto-adjust widths
	{ "folke/neodev.nvim", opts = {} }, -- vim lua cmp
	{ "tpope/vim-surround" },
	change_detection = { notify = false },
})
