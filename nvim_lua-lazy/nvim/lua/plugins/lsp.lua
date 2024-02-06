return {
	{
		-- shows LSP setup info bottom right
		"j-hui/fidget.nvim",
		config = true,
	},
	{
		"neovim/nvim-lspconfig",
		cmd = "Mason",
		event = "BufReadPre",
		dependencies = {
			"williamboman/mason-lspconfig.nvim",
			"williamboman/mason.nvim",
		},
		config = function()
			require("mason").setup({
				ui = {
					icons = {
						package_installed = "✓",
						package_pending = "➜",
						package_uninstalled = "✗",
					},
				},
			})

			local cmp = require("cmp")
			local cmp_select = { behavior = cmp.SelectBehavior.Select }

			cmp.setup({
				sources = {
					{ name = "path" },
					{ name = "nvim_lsp" },
					{ name = "nvim_lua" },
				},
				mapping = cmp.mapping.preset.insert({
					["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
					["<C-n>"] = cmp.mapping.select_next_item(cmp_select),
					["<C-y>"] = cmp.mapping.confirm({ select = true }),
					["<C-Space>"] = cmp.mapping.complete(),
				}),
			})

			require("mason-lspconfig").setup({
				ensure_installed = { "tsserver", "jsonls", "html", "cssls", "lua_ls" },
				handlers = {
					function(server)
						local capabilities = require("cmp_nvim_lsp").default_capabilities()
						require("lspconfig")[server].setup({
							capabilities = capabilities,
						})
					end,
					["lua_ls"] = function()
						local lspconfig = require("lspconfig")
						lspconfig.lua_ls.setup({
							settings = {
								Lua = {
									diagnostics = {
										globals = { "vim" },
									},
								},
							},
						})
					end,
				},
			})

			-- show diagnostic errors
			vim.diagnostic.config({
				virtual_text = {
					prefix = "",
					spacing = 0,
				},
			})

			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("UserLspConfig", {}),
				callback = function(ev)
					-- Enable completion triggered by <c-x><c-o>
					vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"
					-- See `:help vim.lsp.*` for documentation on any of the below functions
					local opts = { buffer = ev.buf }
					vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
					vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
					vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
					vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
					vim.keymap.set("n", "gs", vim.lsp.buf.signature_help, opts)
					vim.keymap.set("n", "<space>D", vim.lsp.buf.type_definition, opts)
					vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, opts)
					vim.keymap.set({ "n", "v" }, "<space>ca", vim.lsp.buf.code_action, opts)
					vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
					vim.keymap.set("n", "<space>f", function()
						vim.lsp.buf.format({ async = true })
					end, opts)
				end,
			})
		end,
	},
	{
		"hrsh7th/nvim-cmp",
		event = "InsertEnter",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-cmdline",
			"hrsh7th/nvim-cmp",
			"L3MON4D3/LuaSnip",
			"saadparwaiz1/cmp_luasnip",
		},
		config = function()
			local cmp = require("cmp")
			-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
			cmp.setup.cmdline({ "/", "?" }, {
				mapping = cmp.mapping.preset.cmdline(),
				sources = {
					{ name = "buffer" },
				},
			})

			-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
			cmp.setup.cmdline(":", {
				mapping = cmp.mapping.preset.cmdline(),
				sources = cmp.config.sources({
					{ name = "path" },
				}, {
					{ name = "cmdline" },
				}),
			})

			cmp.setup({
				snippet = {
					expand = function(args)
						require("luasnip").lsp_expand(args.body) -- For `luasnip` users.
					end,
				},
				mapping = cmp.mapping.preset.insert({
					["<C-b>"] = cmp.mapping.scroll_docs(-4),
					["<C-f>"] = cmp.mapping.scroll_docs(4),
					["<C-Space>"] = cmp.mapping.complete(),
					["<C-e>"] = cmp.mapping.abort(),
					["<CR>"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
				}),
				sources = cmp.config.sources({
					{ name = "path" },
					{ name = "nvim_lsp" },
					{ name = "luasnip" }, -- For luasnip users.
				}, {
					{ name = "buffer" },
				}),
			})
		end,
	},
}

-- return {
-- 	{
-- 		-- shows LSP setup info bottom right
-- 		"j-hui/fidget.nvim",
-- 		config = true,
-- 	},
-- 	{
-- 		"VonHeikemen/lsp-zero.nvim",
-- 		branch = "v3.x",
-- 		lazy = true,
-- 		config = false,
-- 		init = function()
-- 			-- Disable automatic setup, we are doing it manually
-- 			vim.g.lsp_zero_extend_cmp = 0
-- 			vim.g.lsp_zero_extend_lspconfig = 0
-- 		end,
-- 	},
-- 	{
-- 		"williamboman/mason.nvim",
-- 		lazy = false,
-- 		config = true,
-- 	},
--
-- 	-- Autocompletion
-- 	{
-- 		"hrsh7th/nvim-cmp",
-- 		event = "InsertEnter",
-- 		dependencies = {
-- 			{ "L3MON4D3/LuaSnip" },
-- 		},
-- 		config = function()
-- 			-- Here is where you configure the autocompletion settings.
-- 			local lsp_zero = require("lsp-zero")
-- 			lsp_zero.extend_cmp()
--
-- 			-- And you can configure cmp even more, if you want to.
-- 			local cmp = require("cmp")
-- 			local cmp_action = lsp_zero.cmp_action()
--
-- 			cmp.setup({
-- 				formatting = lsp_zero.cmp_format(),
-- 				mapping = cmp.mapping.preset.insert({
-- 					["<C-Space>"] = cmp.mapping.complete(),
-- 					["<C-u>"] = cmp.mapping.scroll_docs(-4),
-- 					["<C-d>"] = cmp.mapping.scroll_docs(4),
-- 					["<C-f>"] = cmp_action.luasnip_jump_forward(),
-- 					["<C-b>"] = cmp_action.luasnip_jump_backward(),
-- 				}),
-- 			})
-- 		end,
-- 	},
--
-- 	-- LSP
-- 	{
-- 		"neovim/nvim-lspconfig",
-- 		cmd = { "LspInfo", "LspInstall", "LspStart" },
-- 		event = { "BufReadPre", "BufNewFile" },
-- 		dependencies = {
-- 			{ "hrsh7th/cmp-nvim-lsp" },
-- 			{ "williamboman/mason-lspconfig.nvim" },
-- 		},
-- 		config = function()
-- 			-- This is where all the LSP shenanigans will live
-- 			local lsp_zero = require("lsp-zero")
-- 			lsp_zero.extend_lspconfig()
--
-- 			lsp_zero.on_attach(function(client, bufnr)
-- 				-- see :help lsp-zero-keybindings
-- 				-- to learn the available actions
-- 				--lsp_zero.default_keymaps({buffer = bufnr})
-- 				local opts = { buffer = bufnr, remap = false }
-- 				vim.keymap.set("n", "gd", function()
-- 					vim.lsp.buf.definition()
-- 				end, opts)
-- 				vim.keymap.set("n", "K", function()
-- 					vim.lsp.buf.hover()
-- 				end, opts)
-- 				vim.keymap.set("n", "<leader>vws", function()
-- 					vim.lsp.buf.workspace_symbol()
-- 				end, opts)
-- 				vim.keymap.set("n", "<leader>vd", function()
-- 					vim.diagnostic.open_float()
-- 				end, opts)
-- 				vim.keymap.set("n", "[d", function()
-- 					vim.diagnostic.goto_next()
-- 				end, opts)
-- 				vim.keymap.set("n", "]d", function()
-- 					vim.diagnostic.goto_prev()
-- 				end, opts)
-- 				vim.keymap.set("n", "<leader>ca", function()
-- 					vim.lsp.buf.code_action()
-- 				end, opts)
-- 				vim.keymap.set("n", "<leader>rr", function()
-- 					vim.lsp.buf.references()
-- 				end, opts)
-- 				vim.keymap.set("n", "<leader>rn", function()
-- 					vim.lsp.buf.rename()
-- 				end, opts)
-- 				vim.keymap.set("i", "<C-h>", function()
-- 					vim.lsp.buf.signature_help()
-- 				end, opts)
-- 			end)
--
-- 			require("mason").setup({})
-- 			require("mason-lspconfig").setup({
-- 				ensure_installed = { "tsserver" },
-- 				handlers = {
-- 					lsp_zero.default_setup,
-- 					lua_ls = function()
-- 						-- (Optional) Configure lua language server for neovim
-- 						local lua_opts = lsp_zero.nvim_lua_ls()
-- 						require("lspconfig").lua_ls.setup(lua_opts)
-- 					end,
-- 				},
-- 			})
--
-- 			local cmp = require("cmp")
-- 			local cmp_select = { behavior = cmp.SelectBehavior.Select }
--
-- 			cmp.setup({
-- 				sources = {
-- 					{ name = "path" },
-- 					{ name = "nvim_lsp" },
-- 					{ name = "nvim_lua" },
-- 				},
-- 				formatting = lsp_zero.cmp_format(),
-- 				mapping = cmp.mapping.preset.insert({
-- 					["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
-- 					["<C-n>"] = cmp.mapping.select_next_item(cmp_select),
-- 					["<C-y>"] = cmp.mapping.confirm({ select = true }),
-- 					["<C-Space>"] = cmp.mapping.complete(),
-- 				}),
-- 			})
-- 		end,
-- 	},
-- }
