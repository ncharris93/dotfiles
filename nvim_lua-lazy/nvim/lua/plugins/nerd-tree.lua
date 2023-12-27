return {
  {
    "preservim/nerdtree",
    keys = {
      { "<C-n>","<cmd>NERDTree<CR>"},
      { "<C-t>","<cmd>NERDTreeToggle<CR>"},
      { "<C-f>","<cmd>NERDTreeFind<CR>"},
    }
  },
  -- add dev icons TODO: remove boxes around icons?
  {
    "ryanoasis/vim-devicons",
    dependencies = {
      {"preservim/nerdtree"},
      {"vim-airline/vim-airline"}
    },
  },
 -- {
 --   "tiagofumo/vim-nerdtree-syntax-highlight",
 --   opts = {
 --     WebDevIconsDisableDefaultFolderSymbolColorFromNERDTreeDir = 1  
 --   }
 -- }

}
