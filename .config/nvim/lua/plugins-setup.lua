local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)


require("lazy").setup({
	{
		"folke/tokyonight.nvim",
		lazy = false, -- make sure we load this during startup if it is your main colorscheme
		priority = 1000, -- make sure to load this before all the other start plugins
		config = function()
		  -- load the colorscheme here
		  vim.cmd([[colorscheme tokyonight]])
		end,
	},

    { "tpope/vim-surround" }, -- Surround ysw)
    { "tpope/vim-commentary" }, -- gcc / gc for comments

    { "nvim-neo-tree/neo-tree.nvim" },
    { "nvim-lua/plenary.nvim" },
    { "nvim-tree/nvim-web-devicons", lazy = true },
    { "itchyny/lightline.vim" },
    { "ThePrimeagen/harpoon" },
    { "ap/vim-css-color" },
    { "mattn/emmet-vim" },
    { "jiangmiao/auto-pairs" },
    { "mbbill/undotree" },
    { "github/copilot.vim" },
    { "lukas-reineke/indent-blankline.nvim" },
})

