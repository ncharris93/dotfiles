return {
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      transparent = true
    },
    -- allows setting for theme without importing LazyVim defaults?
    -- config = function()
    --   vim.cmd([[colorscheme tokyonight-night]])
    -- end
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "tokyonight-night",
    },
  }
}

