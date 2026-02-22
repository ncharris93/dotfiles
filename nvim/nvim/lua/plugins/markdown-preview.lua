return {
	{
		"iamcco/markdown-preview.nvim",
		lazy = true,
		cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
		ft = { "markdown" },
		build = "cd app && npm install",
		keys = {
			{ "<leader>mp", "<cmd>MarkdownPreviewToggle<cr>", "MarkdownPreviewToggle" },
			-- { "<leader>ms", "<cmd>MarkdownPreviewStop<cr>", "MarkdownPreviewStop" },
			-- { "<leader>mr", "<cmd>MarkdownPreview<cr>", "MarkdownPreview" },
		},
	},
}
