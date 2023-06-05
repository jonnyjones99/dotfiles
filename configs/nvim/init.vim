"General vim settings:
:set number
:set relativenumber
:set autoindent
:set tabstop=4
:set shiftwidth=4
:set smarttab
:set softtabstop=4
:set mouse=a
:set background=dark
:set nowrap
:syntax on

"Plugin manager- vim-plug
call plug#begin()

Plug 'https://github.com/preservim/nerdtree' " NerdTree
Plug 'lewis6991/gitsigns.nvim'
Plug 'http://github.com/tpope/vim-surround' " Surrounding ysw)
Plug 'https://github.com/tpope/vim-commentary' " For Commenting gcc & gc
Plug 'https://github.com/vim-airline/vim-airline' " Status bar
Plug 'https://github.com/ap/vim-css-color' " CSS Color Preview
Plug 'https://github.com/terryma/vim-multiple-cursors' " CTRL + N for multiple cursors
Plug 'https://github.com/tpope/vim-commentary' " gcc to comment out a line (takes a count), gc to comment out the target of a motion. gcu uncomments a set of adjacent commented
Plug 'https://github.com/mattn/emmet-vim'
Plug 'https://github.com/rafi/awesome-vim-colorschemes'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'https://github.com/mbbill/undotree'
Plug 'https://github.com/github/copilot.vim'
"fuzzy finder
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
"better tabs and buffer
Plug 'nvim-tree/nvim-web-devicons' " Recommended (for coloured icons)
Plug 'akinsho/bufferline.nvim', { 'tag': '*' }
"indent lines
Plug 'lukas-reineke/indent-blankline.nvim'
call plug#end()


"Auto indent for php files
"Ref: https://stackoverflow.com/questions/6196581/vim-auto-indent-of-html-in-php-filetype-not-working
autocmd FileType php setlocal autoindent

"Remaps for nerdtree:
nnoremap <C-n> :NERDTree<CR>
nnoremap <C-t> :NERDTreeToggle<CR>

"colorscheme
colorscheme spacecamp

"scss support for coc
autocmd FileType scss setl iskeyword+=@-@

"coc settings
hi Normal guibg=NONE ctermbg=NONE
hi NormalNC guibg=NONE ctermbg=NONE
hi CursorLine guibg=NONE ctermbg=NONE
hi EndOfBuffer guibg=NONE ctermbg=NONE
hi NonText guibg=NONE ctermbg=NONE
hi Search cterm=NONE ctermbg=LightMagenta ctermfg=black

"set tab to autocomplete coc
inoremap <silent><expr> <tab> pumvisible() ? coc#_select_confirm() : "\<C-g>u\<TAB>"
inoremap <silent><expr> <cr> "\<c-g>u\<CR>"

"emmet set tab to be leader key
"can do something like .hello followed by 'TAB + ,' to get <div class="hello"></div>	
let g:user_emmet_leader_key='<tab>'

"supposed to format on save but it's not working
command! -nargs=0 Prettier :call CocAction('runCommand', 'prettier.formatFile')

"bufferline setup
" In your init.lua or init.vim
set termguicolors
lua << EOF
require("bufferline").setup{}
EOF

