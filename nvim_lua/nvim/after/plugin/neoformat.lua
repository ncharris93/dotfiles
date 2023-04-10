vim.cmd([[
   let g:neoformat_basic_format_align = 1
   let g:neoformat_try_node_exe = 1

   augroup fmt
      autocmd!
      autocmd BufWritePre * undojoin | Neoformat
   augroup END
]])

vim.keymap.set("n", "<leader>f", vim.cmd.Neoformat)

