return {
	{
		"preservim/nerdtree",
		keys = {
			{ "<C-n>", "<cmd>NERDTree<CR>" },
			{ "<C-t>", "<cmd>NERDTreeToggle<CR>" },
			{ "<C-f>", "<cmd>NERDTreeFind<CR>" },
		},
	},
	--add dev icons TODO: remove boxes around icons?
	{
		"ryanoasis/vim-devicons",
		dependencies = {
			{ "preservim/nerdtree" },
			{ "vim-airline/vim-airline" },
		},
		priority = 1, -- lowest
	},
	{
		"tiagofumo/vim-nerdtree-syntax-highlight",
		init = function()
			vim.g.WebDevIconsDisableDefaultFolderSymbolColorFromNERDTreeDir = 1
			vim.g.WebDevIconsDisableDefaultFileSymbolColorFromNERDTreeFile = 1
		end,
	},
	-- {
	-- 	"nvim-tree/nvim-web-devicons",
	-- 	dependencies = {
	-- 		{ "preservim/nerdtree" },
	-- 		{ "vim-airline/vim-airline" },
	-- 	},
	-- 	priority = 1, -- lowest
	-- 	config = true,
	-- },
}
