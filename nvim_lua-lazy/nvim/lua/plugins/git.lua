return {
	{
		"tpope/vim-fugitive",
		keys = {
			{ "<leader>gs", "<cmd>Git<CR>", desc = "Git Status" },
			{ "<leader>gds", "<cmd>Gvdiffsplit!<CR>", desc = "Git Merge Tool" },
			{ "<leader>gf", "<cmd>diffget //2<CR>", desc = "Accept Left Change" },
			{ "<leader>gh", "<cmd>diffget //3<CR>", desc = "Accept Right Change" },
			{ "<leader>gw", "<cmd>Gwrite<CR>", desc = "Write changes and close split" },
			{ "<leader>gmn", "/<<<<<<<\\|=======\\|>>>>>>><CR>", desc = "Next Merge Conflict" },
			{ "<leader>gmp", "?<<<<<<<\\|=======\\|>>>>>>><CR>", desc = "Previous Merge Conflict" },
		},
	},
}
