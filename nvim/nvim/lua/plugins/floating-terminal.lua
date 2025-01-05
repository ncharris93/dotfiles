return {
	"voldikss/vim-floaterm",
	config = function()
		vim.keymap.set("n", "<leader>ti", ":FloatermToggle myfloat<CR>", { noremap = true, silent = true })
		vim.keymap.set("t", "<ESC>", "<C-\\><C-n>:q<CR>", { noremap = true, silent = true })
	end,
}
