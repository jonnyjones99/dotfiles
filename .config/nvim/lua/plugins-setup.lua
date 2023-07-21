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
	    require("plugins.tokyonight")
	    vim.cmd("colorscheme tokyonight")
		end,
	},

    {
        "nvim-tree/nvim-tree.lua",
        cmd = "NvimTreeToggle",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function()
            require("plugins.nvim-tree")
        end,
    },


    { 
        "rcarriga/nvim-notify",
        config = function()
            vim.notify = require("notify")
        end,
    },


    {
        'akinsho/bufferline.nvim',
        dependencies = 'nvim-tree/nvim-web-devicons',
        config = function()
            require("plugins.bufferline")
        end,
    },


    {
        'nvim-lualine/lualine.nvim',
        dependencies = 'nvim-tree/nvim-web-devicons',
        config = function()
            require("plugins.lualine")
        end,
    },


    { 
        "ThePrimeagen/harpoon",
        dependencies = "nvim-lua/plenary.nvim",
        config = function()
            require("plugins.harpoon")
        end,
    },


    {
        "ibhagwan/fzf-lua",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        -- cmd = "FzfLua files",
        config = function()
        -- calling `setup` is optional for customization
            require("fzf-lua").setup({})
        end
    },

    { "tpope/vim-surround" }, -- Surround ysw)
    { "tpope/vim-commentary" }, -- gcc / gc for comments
    { "nvim-lua/plenary.nvim" },
    { "nvim-tree/nvim-web-devicons", lazy = true },
    { "ap/vim-css-color" },
    { "mattn/emmet-vim" },
    { "jiangmiao/auto-pairs" },
    { "mbbill/undotree" },
    { "github/copilot.vim" },
    { "lukas-reineke/indent-blankline.nvim" },

    --autocomplete and lsp config taken from: https://www.youtube.com/watch?v=vdn_pKJUda8&t=2820s
    
    --Autocomplete
    {
        "hrsh7th/nvim-cmp",
        requires = {
            --autocomplete engines
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            
            --snippets
            "L3MON4D3/LuaSnip",
            "saadparwaiz1/cmp_luasnip",
	    "rafamadriz/friendly-snippets",
        },
        config = function()
            require("plugins.nvim-cmp")
        end,
    },

    { "hrsh7th/cmp-buffer" },
    { "hrsh7th/cmp-path" },
    { "L3MON4D3/LuaSnip" },
    { "saadparwaiz1/cmp_luasnip" },
    { "rafamadriz/friendly-snippets" },


    --lsp
    -- manage + install lsp servers:
    {
        "williamboman/mason.nvim",
        build = ":MasonUpdate", -- update registery contents
        config = function()
            require("plugins.lsp.mason")
        end,
    },

    {
        "williamboman/mason-lspconfig.nvim",
        dependencies = { "williamboman/mason.nvim" },
    },

    --config lsp servers:
    {
        "neovim/nvim-lspconfig",
        dependencies = { "williamboman/mason-lspconfig.nvim" },
    }

})

