return {
	{
		"folke/tokyonight.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			require("tokyonight").setup({
				transparent = true,
				day_brightness = 0.5,
			})
			-- Apply the tokyonight theme settings
			vim.g.tokyonight_transparent = true
			vim.cmd([[colorscheme tokyonight]])

			-- Custom highlight settings for line numbers
			vim.cmd([[
          highlight LineNr guifg=#7aa2f7
          highlight CursorLineNr guifg=#7aa2f7
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
