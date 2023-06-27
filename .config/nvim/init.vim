"General vim settings:
:set number
:set relativenumber
:set autoindent
:set tabstop=4
:set shiftwidth=4
:set smarttab
:set expandtab
:set softtabstop=4
:set mouse=a
:set background=dark
:set nowrap
:set termguicolors
:syntax on
:set ft=phtml

"Plugin manager- vim-plug
call plug#begin()

Plug 'http://github.com/tpope/vim-surround' " Surrounding ysw)
Plug 'nvim-tree/nvim-web-devicons' " optional for nvim tree icons
Plug 'nvim-tree/nvim-tree.lua'
Plug 'https://github.com/tpope/vim-commentary' " For Commenting gcc & gc

"Status bar:
"Plug 'https://github.com/vim-airline/vim-airline' " Status bar
Plug 'itchyny/lightline.vim'

Plug 'https://github.com/ap/vim-css-color' " CSS Color Preview
Plug 'https://github.com/terryma/vim-multiple-cursors' " CTRL + N for multiple cursors
Plug 'https://github.com/tpope/vim-commentary' " gcc to comment out a line (takes a count), gc to comment out the target of a motion. gcu uncomments a set of adjacent commented
Plug 'https://github.com/mattn/emmet-vim'

"Themes:
"Plug 'https://github.com/rafi/awesome-vim-colorschemes'
"Used to use spacecamp from awesoemvimcolorscehems
Plug 'https://github.com/folke/tokyonight.nvim'
Plug 'catppuccin/vim', { 'as': 'catppuccin' }

Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'https://github.com/mbbill/undotree'
Plug 'https://github.com/github/copilot.vim'
"fuzzy finder
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
"better tabs and buffer
Plug 'akinsho/bufferline.nvim', { 'tag': '*' }
"indent lines
Plug 'lukas-reineke/indent-blankline.nvim'
"Start screen
Plug 'mhinz/vim-startify'
"Formatting
Plug 'sbdchd/neoformat'
call plug#end()


"Auto indent for php files
"Ref: https://stackoverflow.com/questions/6196581/vim-auto-indent-of-html-in-php-filetype-not-working
autocmd FileType php setlocal autoindent

"Remaps for nvimtree
nnoremap <C-t> :NvimTreeToggle<CR>	

"Remaps for fuzzyfinder
nmap // :Files<CR>

"Remaps for bufferline
nnoremap <C-l> :BufferLineCycleNext<CR>
nnoremap <C-h> :BufferLineCyclePrev<CR>	

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
"inoremap <silent><expr> <tab> pumvisible() ? coc#_select_confirm() : "\<C-g>u\<TAB>"
"inoremap <silent><expr> <cr> "\<c-g>u\<CR>"

let g:user_emmet_leader_key = '<C-e>'
let g:user_emmet_expandabbr_key = '<C-x><C-e>'
imap <silent><expr> <Tab> <SID>expand()

function! s:expand()
    if pumvisible()
        return "\<C-y>"
    endif
    let col = col('.') - 1
    if !col || getline('.')[col - 1]  =~# '\s'
        return "\<Tab>"
    endif
    return "\<C-x>\<C-e>"
endfunction

"emmet set tab to be leader key
"can do something like .hello followed by 'TAB + ,' to get <div class="hello"></div>	
let g:user_emmet_leader_key='<tab>'

"startify config
let g:startify_bookmarks = [ { 'c': '~/.config/nvim/init.vim' }, { 'z': '~/.config' } ]

let g:startify_custom_header =
			\ startify#pad(readfile('/Users/jonny/Documents/vim-ascii-cat.txt'))


"LUA CONFIG BELOW

set termguicolors
lua <<EOF

--nvim tree
-- disable netrw at the very start of your init.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- set termguicolors to enable highlight groups
vim.opt.termguicolors = true

-- empty setup using defaults
require("nvim-tree").setup()


-- tokyonight setup
require("tokyonight").setup({
  style = "storm", -- The theme comes in three styles, `storm`, `moon`, a darker variant `night` and `day`
  transparent = true, -- Enable this to disable setting the background color
  styles = {
    -- Style to be applied to different syntax groups
    -- Value is any valid attr-list value for `:help nvim_set_hl`
    comments = { italic = true },
    keywords = { italic = true },
    functions = {},
    variables = {},
    -- Background styles. Can be "dark", "transparent" or "normal"
    sidebars = "transparent", -- style for sidebars, see below
    floats = "transparent", -- style for floating windows
  },
  sidebars = { "qf", "help" }, -- Set a darker background on sidebar-like windows. For example: `["qf", "vista_kind", "terminal", "packer"]`
  day_brightness = 0.3, -- Adjusts the brightness of the colors of the **Day** style. Number between 0 and 1, from dull to vibrant colors
  hide_inactive_statusline = false, -- Enabling this option, will hide inactive statuslines and replace them with a thin border instead. Should work with the standard **StatusLine** and **LuaLine**.
  dim_inactive = false, -- dims inactive windows
  lualine_bold = false, -- When `true`, section headers in the lualine theme will be bold
})


--bufferline setup
require('bufferline').setup({
options = {
    show_buffer_close_icons = true,
    themeable = "true",
    numbers= "ordinal",	
    offsets = {
        {
                filetype = "NvimTree",
                text = "File Explorer",
                highlight = "Directory",	
                text_align = "left",
                seperator = true,
        }
        },
        highlights = { 
            pick = {
                guifg = '#100e23',
                guibg = '#87DFEB'
                },
                pick_selected = {
                    guifg = '#100e23',
                    guibg = '#FFE6B3'
                    },
                    pick_visible = {
                        guifg = '#100e23',
                        guibg = '#87DFEB'
                        },
                    },
        }
})


require("indent_blankline").setup {
    show_end_of_line = true,
    buftype_exclude = {
        "nofile",
        "terminal",
    },
    filetype_exclude = {
        "help",
        "startify",
        "aerial",
        "NvimTree",
    },
    show_trailing_blankline_indent = false,
    char = "▏",
    context_char = "▏",
}


--remove the '~' at the end of buffers
--TODO: they are quite useful when editing files so would be nice if it just did it for NvimTree.
vim.opt.fillchars:append { eob = " " }
EOF


"colorscheme
"colorscheme spacecamp
"
colorscheme tokyonight-night
let g:lightline = {'colorscheme': 'tokyonight'}

"colorscheme catppuccin_mocha
"let g:lightline = {'colorscheme': 'catppuccin_mocha'}

