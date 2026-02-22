return {
	{
		"nvim-treesitter/nvim-treesitter",
		branch = "main",
		build = ":TSUpdate",
		lazy = false,
		dependencies = {
			{ "tree-sitter-grammars/tree-sitter-hcl" },
		},
		config = function()
			local parsers = {
				"bash",
				"c",
				"diff",
				"go",
				"hcl",
				"html",
				"javascript",
				"jsdoc",
				"json",
				"jsonc",
				"lua",
				"luadoc",
				"luap",
				"markdown",
				"markdown_inline",
				"python",
				"query",
				"regex",
				"toml",
				"tsx",
				"typescript",
				"vim",
				"vimdoc",
				"yaml",
			}

			require("nvim-treesitter").install(parsers)

			-- Build pattern list from parsers for enabling highlighting + indent
			local patterns = {}
			for _, parser in ipairs(parsers) do
				for _, ft in ipairs(vim.treesitter.language.get_filetypes(parser)) do
					table.insert(patterns, ft)
				end
			end

			vim.api.nvim_create_autocmd("FileType", {
				pattern = patterns,
				callback = function()
					vim.treesitter.start()
					vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
				end,
			})

			vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
				pattern = { "*.db" },
				command = "set filetype=json",
			})
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter-textobjects",
		branch = "main",
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		config = function()
			require("nvim-treesitter-textobjects").setup()

			local move = require("nvim-treesitter-textobjects.move")
			local map = vim.keymap.set
			local opts = { noremap = true, silent = true }

			map({ "n", "x", "o" }, "]f", function() move.goto_next_start("@function.outer") end, opts)
			map({ "n", "x", "o" }, "]c", function() move.goto_next_start("@class.outer") end, opts)
			map({ "n", "x", "o" }, "]F", function() move.goto_next_end("@function.outer") end, opts)
			map({ "n", "x", "o" }, "]C", function() move.goto_next_end("@class.outer") end, opts)
			map({ "n", "x", "o" }, "[f", function() move.goto_previous_start("@function.outer") end, opts)
			map({ "n", "x", "o" }, "[c", function() move.goto_previous_start("@class.outer") end, opts)
			map({ "n", "x", "o" }, "[F", function() move.goto_previous_end("@function.outer") end, opts)
			map({ "n", "x", "o" }, "[C", function() move.goto_previous_end("@class.outer") end, opts)
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter-context",
		config = function()
			require("treesitter-context").setup({
				enable = true, -- Enable this plugin (Can be enabled/disabled later via commands)
				max_lines = 5, -- How many lines the window should span. Values <= 0 mean no limit.
				min_window_height = 0, -- Minimum editor window height to enable context. Values <= 0 mean no limit.
				line_numbers = true,
				multiline_threshold = 20, -- Maximum number of lines to show for a single context
				trim_scope = "outer", -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
				mode = "cursor", -- Line used to calculate context. Choices: 'cursor', 'topline'
				-- Separator between context and content. Should be a single character string, like '-'.
				-- When separator is set, the context will only show up when there are at least 2 lines above cursorline.
				separator = nil,
				zindex = 20, -- The Z-index of the context window
				on_attach = nil, -- (fun(buf: integer): boolean) return false to disable attaching
			})
		end,
	},
}
