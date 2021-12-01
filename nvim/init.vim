
source $HOME/.config/nvim/plug-config/coc.vim

" Ignore files
set wildignore+=*_build/*
set wildignore+=**/coverage/*
set wildignore+=**/node_modules/*
set wildignore+=**/android/*
set wildignore+=**/ios/*
set wildignore+=**/.git/*
"
" Plugin stuffs
call plug#begin('~/.vim/plugged')

"LSP config
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/nvim-cmp'
Plug 'tzachar/cmp-tabnine', { 'do': './install.sh' }
Plug 'onsails/lspkind-nvim'
Plug 'github/copilot.vim'
"
" git stuff
Plug 'tpope/vim-fugitive'
Plug 'vim-airline/vim-airline' "show current branch
Plug 'tpope/vim-rhubarb'

Plug 'mbbill/undotree'

" telescope requirements...
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzy-native.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'ThePrimeagen/harpoon'

Plug 'gruvbox-community/gruvbox'

" Neovim Tree shitter
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-treesitter/playground'

" prettier
Plug 'sbdchd/neoformat'

" Inetllisense
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" dracula
Plug 'dracula/vim', { 'as': 'dracula' }

" TypeScript stuff?
Plug 'neovim/nvim-lspconfig'
Plug 'jose-elias-alvarez/null-ls.nvim'
Plug 'jose-elias-alvarez/nvim-lsp-ts-utils'

" run build & test commands
Plug 'tpope/vim-dispatch'

" autocomplete pairs
"Plug 'rstacruz/vim-closer'
"Plug 'tpope/vim-endwise'


Plug 'terryma/vim-multiple-cursors'

" prettier
Plug 'sbdchd/neoformat'
 
"todo
Plug 'vuciv/vim-bujo'

call plug#end()

lua require'nvim-treesitter.configs'.setup { highlight = { enable = true }, incremental_selection = { enable = true }, textobjects = { enable = true }}
""// TypeScript grammar
"require'tree-sitter-typescript'.typescript; 
""// TSX grammar
"require'tree-sitter-typescript'.tsx;

"require("telescope").load_extension('harpoon')
"lua require("theprimeagen")



set tabstop=4 softtabstop=4
set shiftwidth=4
set expandtab
set smartindent

set exrc
set relativenumber
set nohlsearch
set nu
set hidden
set noerrorbells
set nowrap

" history based
set noswapfile
set nobackup
set undodir=~/.vim/undodir
set undofile

set incsearch
set scrolloff=8
set signcolumn=auto:2
set colorcolumn=80

set cmdheight=2

set updatetime=50
set shortmess+=c



let mapleader = " "
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>

nnoremap <leader>bs /<C-R>=escape(expand("<cWORD>"), "/")<CR><CR>
nnoremap <leader>u :UndotreeShow<CR>
nnoremap <leader>pv :Ex<CR>

nnoremap <Leader><CR> :so ~/.config/nvim/init.vim<CR>
nnoremap <Leader>+ :vertical resize +5<CR>
nnoremap <Leader>- :vertical resize -5<CR>

nnoremap <leader>gll :let g:_search_term = expand("%")<CR><bar>:Gclog -- %<CR>:call search(g:_search_term)<CR>
nnoremap <leader>gln :cnext<CR>:call search(_search_term)<CR>
nnoremap <leader>glp :cprev<CR>:call search(_search_term)<CR>

"harpoon
nnoremap <leader>hh :lua require("harpoon.mark").add_file()
nnoremap <leader>hg :lua require("harpoon.ui").toggle_quick_menu()
nnoremap <leader>h1 :lua require("harpoon.ui").nav_file(1)
nnoremap <leader>h2 :lua require("harpoon.ui").nav_file(2)
nnoremap <leader>h3 :lua require("harpoon.ui").nav_file(3)
nnoremap <leader>h4 :lua require("harpoon.ui").nav_file(4)

vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

nnoremap Y yg$
nnoremap n nzzzv
nnoremap N Nzzzv
nnoremap J mzJ`z

" gir remaps
nmap <leader>gh :G<CR>
nmap <leader>gj :diffget //3<CR>
nmap <leader>gf :diffget //2<CR>
 
"vim todo
nmap <Leader>tu <Plug>BujoChecknormal
nmap <Leader>th <Plug>BujoAddnormal
let g:bujo#todo_file_path = $HOME . "/.cache/bujo"

" not sure what these do?
" greatest remap ever
xnoremap <leader>p "_dP

" next greatest remap ever : asbjornHaland
nnoremap <leader>y "+y
vnoremap <leader>y "+y
nnoremap <leader>Y gg"+yG

let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'

if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif


"packadd! dracula
syntax enable
"colorscheme dracula
colorscheme gruvbox
highlight Normal guibg=none

augroup highlight_yank
    autocmd!
    autocmd TextYankPost * silent! lua require'vim.highlight'.on_yank({timeout = 40})
augroup END

augroup THE_PRIMEAGEN
    autocmd!
    "autocmd BufWritePre ts,tsx Neoformat
    "autocmd BufWritePre * undojoin | Neoformat
    autocmd BufWritePre *ts Neoformat
    "autocmd BufWritePre *tsx Neoformat
    "autocmd BufWritePre lua,cpp,c,h,hpp,cxx,cc Neoformat
    "autocmd BufWritePre * %s/\s\+$//e
    "autocmd BufEnter,BufWinEnter,TabEnter *.rs :lua require'lsp_extensions'.inlay_hints{}
augroup END

