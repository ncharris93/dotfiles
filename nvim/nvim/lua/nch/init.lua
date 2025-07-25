require("nch.remap")
require("nch.set")

local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

local yank_group = augroup("HighlightYank", {})
autocmd("TextYankPost", {
	group = yank_group,
	pattern = "*",
	callback = function()
		vim.highlight.on_yank({
			higroup = "IncSearch",
			timeout = 40,
		})
	end,
})

-- Initialize theme switcher after all plugins are loaded
autocmd("VimEnter", {
	callback = function()
		local theme_switcher = require("nch.theme-switcher")
		theme_switcher.init()
	end,
})
