return {
	{
		"tpope/vim-fugitive",
		keys = {
			{ "<leader>gs", "<cmd>Git<CR>", desc = "Git Status" },
			{ "<leader>gf", "<cmd>diffget //2<CR>", desc = "Accept Left(cur) Change" },
			{ "<leader>gj", "<cmd>diffget //3<CR>", desc = "Accept Right(inc) Change" },
			{ "<leader>gw", "<cmd>Gwrite<CR>", desc = "Write changes and close split" },
			{ "<leader>gn", "/<<<<<<<\\|=======\\|>>>>>>><CR>", desc = "Next Merge Conflict" },
			{ "<leader>gp", "?<<<<<<<\\|=======\\|>>>>>>><CR>", desc = "Previous Merge Conflict" },
		},
	},
}
