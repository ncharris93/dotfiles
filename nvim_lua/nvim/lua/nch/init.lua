require("nch.remap")
require("nch.set")

local augroup = vim.api.nvim_create_augroup
local nchGroup = augroup('nch', {})

local autocmd = vim.api.nvim_create_autocmd
local yank_group = augroup('HighlightYank', {})

autocmd({"BufWritePre"}, {
    group = nchGroup,
    pattern = "*",
    command = [[%s/\s\+$//e]],
})
