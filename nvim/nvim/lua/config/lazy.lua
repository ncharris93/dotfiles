local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.uv.fs_stat(lazypath) then
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
	{ import = "plugins" },
	{ "LazyVim/LazyVim" },
	{ "lukas-reineke/indent-blankline.nvim", main = "ibl", opts = {} }, -- line indenting
	{ "tpope/vim-sleuth" }, -- auto-adjust widths
	change_detection = { notify = false },
})
