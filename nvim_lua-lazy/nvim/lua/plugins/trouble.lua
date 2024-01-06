return {
	"folke/trouble.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = true,
	keys = {
		{
			"<leader>tt",
			function()
				require("trouble").toggle()
			end,
			desc = "toggle issue buffer",
		},
		{
			"<leader>tn",
			function()
				require("trouble").next({ skip_groups = true, jump = true })
			end,
			desc = "trouble - next issue",
		},
		{
			"<leader>tp",
			function()
				require("trouble").previous({ skip_groups = true, jump = true })
			end,
			desc = "trouble - next issue",
		},
	},
}
