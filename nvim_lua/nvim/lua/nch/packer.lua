-- This file can be loaded by calling `lua require('plugins')` from your init.vim


-- bootstrap packer so that it's always installed
local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
   -- Packer can manage itself
   use 'wbthomason/packer.nvim'

   use {
      'nvim-telescope/telescope.nvim', tag = '0.1.0',
      -- or                            , branch = '0.1.x',
      requires = { { 'nvim-lua/plenary.nvim' } }
   }

   use({
      'rose-pine/neovim',
      as = 'rose-pine',
      config = function()
         vim.cmd('colorscheme rose-pine')
      end
   })

   use('nvim-treesitter/nvim-treesitter', { run = ':TSUpdate' })
   use('nvim-treesitter/playground')
   use('theprimeagen/harpoon')
   use('mbbill/undotree')
   use('tpope/vim-fugitive')

   use {
      'VonHeikemen/lsp-zero.nvim',
      requires = {
         -- LSP Support
         { 'neovim/nvim-lspconfig' },
         { 'williamboman/mason.nvim' },
         { 'williamboman/mason-lspconfig.nvim' },

         -- Autocompletion
         { 'hrsh7th/nvim-cmp' },
         { 'hrsh7th/cmp-buffer' },
         { 'hrsh7th/cmp-path' },
         { 'saadparwaiz1/cmp_luasnip' },
         { 'hrsh7th/cmp-nvim-lsp' },
         { 'hrsh7th/cmp-nvim-lua' },

         -- Snippets
         { 'L3MON4D3/LuaSnip' },
         { 'rafamadriz/friendly-snippets' },
      }
   }

   use('preservim/nerdtree') -- dir manipulation
   use('jiangmiao/auto-pairs') -- autocomplete autoclose pairs

   use('airblade/vim-gitgutter') -- git gutter icons
   use('vim-airline/vim-airline') -- show current branch
   use('mfussenegger/nvim-lint') -- linting

   use 'sbdchd/neoformat' -- formatting

end)
