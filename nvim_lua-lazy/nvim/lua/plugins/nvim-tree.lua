return {
	{
		"nvim-tree/nvim-tree.lua",
		lazy = false,
		dependencies = {
			{ "nvim-tree/nvim-web-devicons" },
		},
		opts = {
			filters = {
				dotfiles = false,
				custom = { ".DS_Store" },
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
			{ "<C-+>", "<cmd>NvimTreeResize +20" },
			{ "<C-->", "<cmd>NvimTreeResize -20" },
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
