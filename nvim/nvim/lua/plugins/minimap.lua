return {
  -- {
  --   "wfxr/minimap.vim", 
  --   init = function()
  --      vim.g.minimap_width = 5
  --      vim.g.minimap_auto_start = 1
  --      vim.g.minimap_auto_start_win_enter = 1
  --   end,
  -- },
  --  can't be used with nvim-scrollview
  -- {
  --   "dsummersl/nvim-sluice", 
  --    config = true
  -- }, 
  {
    "dstein64/nvim-scrollview",
    config = true
  }
}

-- { "lewis6991/satellite.nvim" } -- requires neovim 10
