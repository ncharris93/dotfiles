return {
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.5",
		dependencies = { "nvim-lua/plenary.nvim" },
		keys = {
			{
				-- find word under cursor
				"<leader>fw",
				function()
					local builtin = require("telescope.builtin")
					local word = vim.fn.expand("<cword>")
					builtin.grep_string({ search = word })
				end,
				desc = "find word under cursor",
			},
			-- find full word under cursor
			{
				"<leader>fW",
				function()
					local builtin = require("telescope.builtin")
					local word = vim.fn.expand("<cWORD>")
					builtin.grep_string({ search = word })
				end,
				desc = "find full word under cursor",
			},
			{
				"<leader>fr",
				function()
					local builtin = require("telescope.builtin")
					local word = vim.fn.expand("<cWORD>")
					builtin.lsp_references({ search = word })
				end,
				desc = "find references",
			},
			{ "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "find files" },
			{ "<leader>fhi", "<cmd>Telescope find_files hidden=true<cr>", desc = "find incl hidden" },
			{
				"<leader>fgi",
				function()
					require("telescope.builtin").live_grep({
						additional_args = { "--hidden", "--no-ignore" },
						glob_pattern = "!.git/",
					})
				end,
				desc = "grep incl dotfiles",
			},
			{ "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "grep" },
			{ "<leader>fgb", "<cmd>Telescope git_branches<cr>", desc = "git branches" },
			{ "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "find buffers" },
			{ "<leader>fh", "<cmd>Telescope help_tags<cr>", desc = "find help tags" },
			{ "<leader><C-p>", "<cmd>Telescope git_files<cr>", desc = "find git files" },
		},
		opts = {
			defaults = {
				path_display = { "truncate" },
				truncate = 3,
				-- pickers = {
				-- 	find_files = {
				-- 		find_command = {
				-- 			"rg",
				-- 			"--sortr=modified",
				-- 			"--files",
				-- 			"--hidden",
				-- 			"--no-ignore",
				-- 			"--glob",
				-- 			"!.git",
				-- 		},
				-- 	},
				-- },
			},
		},
	},
	{
		"nvim-telescope/telescope-fzf-native.nvim",
		build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
		config = function()
			require("telescope").load_extension("fzf")
		end,
	},
}
