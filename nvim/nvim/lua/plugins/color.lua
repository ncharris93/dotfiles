return {
	{
		"folke/tokyonight.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			require("tokyonight").setup({
				transparent = true,
				day_brightness = 0.5,
				on_highlights = function(hl)
					hl.LineNrAbove = {
						fg = "#6ab8ff",
					}
					hl.LineNrBelow = {
						fg = "#ff6188",
					}
				end,
			})
			-- Apply the tokyonight theme settings
			vim.g.tokyonight_transparent = true
			vim.cmd([[colorscheme tokyonight]])

			-- Custom highlight settings for line numbers
			-- highlight CursorLineNr guifg=#a9b1d6
			vim.cmd([[
				highlight LineNr guifg=#5eacd3
				highlight CursorLineNr guifg=#5eacd3
				highlight Comment guifg=#a9b1d6
			]])
		end,
	},
	{
		"norcalli/nvim-colorizer.lua",
		event = "BufReadPost",
		config = function()
			require("colorizer").setup({
				"*", -- Enable colorizer for all file types
			})
		end,
	},
}
