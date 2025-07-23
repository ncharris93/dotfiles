return {
	{
		"catppuccin/nvim",
		name = "catppuccin",
		priority = 1000,
		config = function()
			require("catppuccin").setup({
				flavour = "latte", -- latte, frappe, macchiato, mocha
				transparent_background = true,
				show_end_of_buffer = false,
				term_colors = false,
				dim_inactive = {
					enabled = false,
					shade = "dark",
					percentage = 0.15,
				},
				no_italic = false,
				no_bold = false,
				no_underline = false,
				styles = {
					comments = { "italic" },
					conditionals = { "italic" },
					loops = {},
					functions = {},
					keywords = {},
					strings = {},
					variables = {},
					numbers = {},
					booleans = {},
					properties = {},
					types = {},
					operators = {},
				},
				integrations = {
					cmp = true,
					gitsigns = true,
					nvimtree = true,
					treesitter = true,
					notify = false,
					mini = {
						enabled = true,
						indentscope_color = "",
					},
				},
			})
		end,
	},
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
			
			-- Just set up tokyonight, theme switching will be handled separately
			vim.g.tokyonight_transparent = true
			vim.cmd([[colorscheme tokyonight-night]])

			-- Custom highlight settings for line numbers
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
