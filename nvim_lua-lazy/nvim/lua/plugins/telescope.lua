return {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.5',
    dependencies = { 'nvim-lua/plenary.nvim' },
    keys={
      { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "find files"},
      { "<leader>fgh", "<cmd>Telescope find_files hidden=true<cr>", desc = "find hidden"},
      { "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "grep"},
      { "<leader>fb", "<cmd>Telescope buffers<cr>"},
      { "<leader>fh", "<cmd>Telescope help_tags<cr>"},
      { "<leader><C-p>", "<cmd>Telescope git_files<cr>"}
    },
    opts = {
      defaults = {
        path_display = { "truncate" },
        truncate = 3
      }
    }
}


--    keys = {
--      {
--        "<leader>,",
--        "<cmd>Telescope buffers sort_mru=true sort_lastused=true<cr>",
--        desc = "Switch Buffer",
--      },
--      { "<leader>:", "<cmd>Telescope command_history<cr>", desc = "Command History" },
--      -- find
--      { "<leader>fb", "<cmd>Telescope buffers sort_mru=true sort_lastused=true<cr>", desc = "Buffers" },
--      { "<leader>fr", "<cmd>Telescope oldfiles<cr>", desc = "Recent" },
--      -- git
--      { "<leader>gc", "<cmd>Telescope git_commits<CR>", desc = "commits" },
--      { "<leader>gs", "<cmd>Telescope git_status<CR>", desc = "status" },
--      -- search
--      { '<leader>s"', "<cmd>Telescope registers<cr>", desc = "Registers" },
--      { "<leader>sa", "<cmd>Telescope autocommands<cr>", desc = "Auto Commands" },
--      { "<leader>sb", "<cmd>Telescope current_buffer_fuzzy_find<cr>", desc = "Buffer" },
--      { "<leader>sc", "<cmd>Telescope command_history<cr>", desc = "Command History" },
--      { "<leader>sC", "<cmd>Telescope commands<cr>", desc = "Commands" },
--      { "<leader>sd", "<cmd>Telescope diagnostics bufnr=0<cr>", desc = "Document diagnostics" },
--      { "<leader>sD", "<cmd>Telescope diagnostics<cr>", desc = "Workspace diagnostics" },
--      { "<leader>sh", "<cmd>Telescope help_tags<cr>", desc = "Help Pages" },
--      { "<leader>sH", "<cmd>Telescope highlights<cr>", desc = "Search Highlight Groups" },
--      { "<leader>sk", "<cmd>Telescope keymaps<cr>", desc = "Key Maps" },
--      { "<leader>sM", "<cmd>Telescope man_pages<cr>", desc = "Man Pages" },
--      { "<leader>sm", "<cmd>Telescope marks<cr>", desc = "Jump to Mark" },
--      { "<leader>so", "<cmd>Telescope vim_options<cr>", desc = "Options" },
--      { "<leader>sR", "<cmd>Telescope resume<cr>", desc = "Resume" },
--      {
--        "<leader>ss",
--        function()
--          require("telescope.builtin").lsp_document_symbols({
--            symbols = require("lazyvim.config").get_kind_filter(),
--          })
--        end,
--        desc = "Goto Symbol",
--      },
--      {
--        "<leader>sS",
--        function()
--          require("telescope.builtin").lsp_dynamic_workspace_symbols({
--            symbols = require("lazyvim.config").get_kind_filter(),
--          })
--        end,
--        desc = "Goto Symbol (Workspace)",
--      },
--    },
