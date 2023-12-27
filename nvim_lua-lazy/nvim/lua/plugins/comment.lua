return {
  {
    'numToStr/Comment.nvim',
    dependencies = {
      "JoosepAlviste/nvim-ts-context-commentstring",
      'nvim-treesitter/nvim-treesitter',
    },
    config = function ()
      require('Comment').setup {
        pre_hook = function()
          return vim.bo.commentstring
        end
      }
    end,
    lazy = false,
    event = {"BufWritePre","BufNewFile"},
  }
}
