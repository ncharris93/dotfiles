return {
	{
		"nvim-tree/nvim-tree.lua",
		lazy = false,
		dependencies = {
			{ "nvim-tree/nvim-web-devicons" },
		},
		config = {
			filters = {
				dotfiles = false,
			},
			actions = {
				open_file = {
					quit_on_open = true,
				},
			},
		},
		keys = {
			{ "<C-t>", "<cmd>NvimTreeToggle<CR>" },
			{ "<C-f>", "<cmd>NvimTreeFindFile<CR>" },
		},
	},
	{
		"nvim-tree/nvim-web-devicons",
		dependencies = {
			{ "vim-airline/vim-airline" },
		},
		priority = 1, -- lowest
		config = true,
	},
}
