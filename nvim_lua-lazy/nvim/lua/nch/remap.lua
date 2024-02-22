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
keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")
keymap.set("n", "<leader>f", vim.lsp.buf.format)

keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })

-- run js files
keymap.set("n", "<leader>ts", "<cmd>!ts-node % <CR>")
keymap.set("n", "<leader>js", "<cmd>!node % <CR>")

-- fold current block
keymap.set("n", "<leader>fo", "viBzF<CR>")

-- Pane Navigation
keymap.set("n", "<C-h>", "<C-w>h")
keymap.set("n", "<C-j>", "<C-w>j")
keymap.set("n", "<C-k>", "<C-w>k")
keymap.set("n", "<C-l>", "<C-w>l")

-- quickfix navigation
keymap.set("n", "<C-]>", "<cmd>cn<CR>")
keymap.set("n", "<C-[>", "<cmd>cp<CR>")

-- Pane Resizing
keymap.set("n", "<Leader>+", "<C-w>><CR>")
keymap.set("n", "<Leader>-", "<C-w><<CR>")

function ToggleVerbose()
	local home = os.getenv("HOME")
	local verbose_file = home .. "/.cache/nvim/verbose.log"

	if vim.o.verbose == 0 then
		print("verbose logging to " .. verbose_file)
		vim.o.verbosefile = verbose_file
		vim.o.verbose = 15
	else
		print("Verbose logging disabled")
		vim.o.verbose = 0
		vim.o.verbosefile = ""
	end
end

keymap.set("n", "<leader>tv", ":lua ToggleVerbose()<CR>", { silent = true, noremap = true })
