return {
  {
    'numToStr/Comment.nvim',
    dependencies = {
      "JoosepAlviste/nvim-ts-context-commentstring",
      'nvim-treesitter/nvim-treesitter',
    },
    config = function ()
      ---@diagnostic disable-next-line: missing-fields
      require('ts_context_commentstring').setup {
        enable_autocmd = false,
      }
      require('Comment').setup {
        pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook(),
      }
    end,
    lazy = false,
    event = {"BufWritePre","BufNewFile"},
  }
}
