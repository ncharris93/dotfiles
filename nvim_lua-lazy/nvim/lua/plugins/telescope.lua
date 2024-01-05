return {
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.5",
		dependencies = { "nvim-lua/plenary.nvim" },
		init = function()
			local builtin = require("telescope.builtin")

			function vim.getVisualSelection()
				vim.cmd('noau normal! "vy"')
				local text = vim.fn.getreg("v")
				vim.fn.setreg("v", {})

				text = string.gsub(text, "\n", "")
				if #text > 0 then
					return text
				else
					return ""
				end
			end

			vim.keymap.set("v", "<leader>ff", function()
				local text = vim.getVisualSelection()
				builtin.current_buffer_fuzzy_find({ default_text = text })
			end)

			vim.keymap.set("v", "<leader>fg", function()
				local text = vim.getVisualSelection()
				builtin.live_grep({ default_text = text })
			end)
		end,
		keys = {
			{ "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "find files" },
			{ "<leader>fgh", "<cmd>Telescope find_files hidden=true<cr>", desc = "find hidden" },
			{ "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "grep" },
			{ "<leader>fb", "<cmd>Telescope buffers<cr>" },
			{ "<leader>fh", "<cmd>Telescope help_tags<cr>" },
			{ "<leader><C-p>", "<cmd>Telescope git_files<cr>" },
		},
		opts = {
			defaults = {
				path_display = { "truncate" },
				truncate = 3,
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
