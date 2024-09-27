return {
	"folke/trouble.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = {},
	keys = {
		{
			"<leader>tt",
			"<cmd>Trouble diagnostics toggle<cr>",
			desc = "toggle issue buffer",
		},
		{
			"<leader>tn",
			"<cmd>Trouble diagnostics next = {skip_groups = true, jump=true}<cr>",
			function()
				require("trouble").next({ skip_groups = true, jump = true })
			end,
			desc = "trouble - next issue",
		},
		{
			"<leader>tp",
			"<cmd>Trouble diagnostics previous<cr>",
			function()
				require("trouble").previous({ skip_groups = true, jump = true })
			end,
			desc = "trouble - next issue",
		},
	},
}
