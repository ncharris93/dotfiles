local keymap = vim.keymap

vim.g.mapleader = " "
keymap.set("n", "<leader>pv", vim.cmd.Ex)

-- move highlighted blocks of code
keymap.set("v", "J", ":m '>+1<CR>gv=gv")
keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- keep J from going to EoL
keymap.set("n", "J", "mzJ`z")

-- keep jump on search terms in the middle
keymap.set("n", "n", "nzzzv")
keymap.set("n", "N", "Nzzzv")

-- greatest remap ever: when pasting over a highlighted term,
-- don't replace register with deleted text
keymap.set("x", "<leader>p", [["_dP]])

-- next greatest remap ever : asbjornHaland
-- yank to clipboard
keymap.set({ "n", "v" }, "<leader>y", [["+y]])
keymap.set("n", "<leader>Y", [["+Y]])
-- when deleting, dont replace register with deleted text
keymap.set({ "n", "v" }, "<leader>d", [["_d]])

-- allow vertical editing to update files when using ctrl c
keymap.set("i", "<C-c>", "<Esc>")

keymap.set("n", "Q", "<nop>")
-- keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")
keymap.set("n", "<leader>f", vim.lsp.buf.format)

keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz", { desc = "next location list item" })
keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz", { desc = "previous location list item" })

keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], { desc = "search and replace" })
keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })

-- run js files
keymap.set("n", "<leader>ts", "<cmd>!ts-node % <CR>")
keymap.set("n", "<leader>js", "<cmd>!node % <CR>")

-- fold current block
keymap.set("n", "<leader>fo", "viBzF<CR>", { desc = "fold current block" })

-- Pane Navigation
keymap.set("n", "<C-h>", "<C-w>h")
keymap.set("n", "<C-j>", "<C-w>j")
keymap.set("n", "<C-k>", "<C-w>k")
keymap.set("n", "<C-l>", "<C-w>l")

-- quickfix navigation
keymap.set("n", "<C-]>", "<cmd>cn<CR>")
keymap.set("n", "<C-[>", "<cmd>cp<CR>")

-- Pane Resizing
--keymap.set("n", "<Leader>+", "<C-w>><CR>")
--keymap.set("n", "<Leader>-", "<C-w><<CR>")

-- reload the config
vim.keymap.set("n", "<leader>rr", function()
	-- Clear and reset require cache
	for name, _ in pairs(package.loaded) do
		if name:match("^plugins") or name:match("^nch") or name:match("^config") then
			package.loaded[name] = nil
		end
	end
	-- Source init.lua
	vim.cmd("source $MYVIMRC")
	vim.notify("Neovim config reloaded!", vim.log.levels.INFO)
end, { desc = "Reload nvim config" })
