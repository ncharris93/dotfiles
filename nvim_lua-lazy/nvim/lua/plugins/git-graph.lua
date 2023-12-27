return {
  {
    "rbong/vim-flog",
    lazy = true,
    cmd = { "Flog", "Flogsplit", "Floggit" },
    dependencies = {
      "tpope/vim-fugitive",
    },
    keys = {
      {"<leader>gg", "<cmd>Flogsplit<CR>"}
    }
  },
}
