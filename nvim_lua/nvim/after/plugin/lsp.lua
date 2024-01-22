local lsp = require("lsp-zero")

lsp.preset("recommended")

lsp.ensure_installed({
	"tsserver",
	"eslint",
	"rust_analyzer",
})

-- Fix Undefined global 'vim'
lsp.configure("lua_ls", {
	settings = {
		Lua = {
			diagnostics = {
				globals = { "vim" },
			},
		},
	},
})

local cmp = require("cmp")
local cmp_select = { behavior = cmp.SelectBehavior.Select }
lsp.defaults.cmp_mappings({
	["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
	["<C-n>"] = cmp.mapping.select_next_item(cmp_select),
	["<C-y>"] = cmp.mapping.confirm({ select = true }),
	["<C-Space>"] = cmp.mapping.complete(),
})

lsp.on_attach(function(client, bufnr)
	local opts = { buffer = bufnr, remap = false }

	if client.name == "eslint" then
		vim.cmd.LspStop("eslint")
		return
	end

	vim.keymap.set("n", "gd", vim.lsp.buf.definition)
	vim.keymap.set("n", "K", vim.lsp.buf.hover)
	vim.keymap.set("n", "<leader>vws", vim.lsp.buf.workspace_symbol)
	vim.keymap.set("n", "<leader>vd", vim.diagnostic.open_float)
	vim.keymap.set("n", "[d", vim.diagnostic.goto_next)
	vim.keymap.set("n", "]d", vim.diagnostic.goto_prev)
	vim.keymap.set("n", "<leader>vca", vim.lsp.buf.code_action)
	vim.keymap.set("n", "<leader>vrr", vim.lsp.buf.references)
	vim.keymap.set("n", "<leader>vrn", vim.lsp.buf.rename)
	vim.keymap.set("i", "<C-h>", vim.lsp.buf.signature_help)
end)

lsp.setup({})
