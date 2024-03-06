local opt = vim.opt

--leader key space
vim.g.mapleader = " "

--line numbers
opt.relativenumber = true
opt.number = true

--tabs
opt.tabstop = 4
opt.shiftwidth = 4
opt.expandtab = true
opt.smarttab = true
opt.softtabstop = 4
opt.autoindent = true
opt.smartindent = true

--nowrap
opt.wrap = false

--search settings
opt.ignorecase = true

--appearnace
opt.termguicolors = true
opt.background = "dark"
opt.cursorline = true

--backspace
opt.backspace = "indent,eol,start"

--clipboard
--use clipboard when copying and pasting finally
opt.clipboard:append("unnamedplus")

--split windows = always to below and to the right
opt.splitright = true
opt.splitbelow = true

--undo file
opt.undofile = true

--keep scroll in view
opt.scrolloff = 8
opt.sidescrolloff = 8

--smart case and indent
opt.smartindent = true
opt.smartcase = true

--just in case
opt.encoding = "utf-8"

--better messages if vim-notify doesn't work
opt.cmdheight = 2

--highlight matching parenthesis
vim.opt.showmatch = true

--highlight on yank
vim.cmd("au TextYankPost * lua vim.highlight.on_yank {on_visual = false}")

--php
vim.cmd("autocmd bufnewfile,bufread *.php set filetype=php")

--templ go
vim.filetype.add({ extensions = { templ = "templ" } })
vim.cmd("autocmd bufnewfile,bufread *.templ set filetype=templ")
