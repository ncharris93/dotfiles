return {
  -- add dracula
  {"Mofiqul/dracula.nvim", 
    opts = {
      transparent_bg = true,
    }
  },

  -- Configure LazyVim to load dracula  
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "dracula",
    },
  }
}
