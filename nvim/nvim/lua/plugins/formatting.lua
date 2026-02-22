return {
	{
		"stevearc/conform.nvim",
		lazy = true,
		event = { "BufWritePre" },
		cmd = { "ConformInfo" },
		keys = {
			{
				"<leader>fm",
				function()
					require("conform").format({ timeout_ms = 500, lsp_fallback = true })
				end,
				desc = "Format Document",
			},
		},
		opts = {
			formatters_by_ft = {
				lua = { "stylua" },
				python = { "isort", "black" },
				javascript = { "prettier", "biome", stop_after_first = true },
				typescript = { "prettier", "biome", stop_after_first = true },
				javascriptreact = { "prettier", "biome", stop_after_first = true },
				typescriptreact = { "prettier", "biome", stop_after_first = true },
				css = { "prettier", "biome", stop_after_first = true },
				html = { "prettier" },
				json = { "prettier", "biome", stop_after_first = true },
				yaml = { "prettier" },
				markdown = { "prettier" },
			},
			formatters = {
				prettier = {
					condition = function(self, ctx)
						return vim.fs.find({
							".prettierrc",
							".prettierrc.json",
							".prettierrc.yml",
							".prettierrc.yaml",
							".prettierrc.js",
							".prettierrc.cjs",
							".prettierrc.mjs",
							"prettier.config.js",
							"prettier.config.cjs",
							"prettier.config.mjs",
						}, { path = ctx.dirname, upward = true })[1] ~= nil
					end,
				},
			},
			format_on_save = {
				timeout_ms = 2500,
				lsp_fallback = true,
			},
		},
	},
}
