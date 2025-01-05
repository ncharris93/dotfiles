return {
	{
		"iamcco/markdown-preview.nvim",
		lazy = true,
		cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
		ft = { "markdown" },
		build = function()
			vim.fn["mkdp#util#install"]()
		end,
		keys = {
			{ "<leader>mp", "<cmd>MarkdownPreviewToggle<cr>", "MarkdownPreviewToggle" },
			-- { "<leader>ms", "<cmd>MarkdownPreviewStop<cr>", "MarkdownPreviewStop" },
			-- { "<leader>mr", "<cmd>MarkdownPreview<cr>", "MarkdownPreview" },
		},
	},
}
