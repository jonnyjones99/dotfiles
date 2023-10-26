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
			-- annoying hack to get rid of no lsp info message
			-- See https://github.com/neovim/nvim-lspconfig/issues/1931#issuecomment-1297599534
			-- An alternative solution: https://github.com/neovim/neovim/issues/20457#issuecomment-1266782345
			local banned_messages = { "No information available" }
			vim.notify = function(msg, ...)
				for _, banned in ipairs(banned_messages) do
					if msg == banned then
						return
					end
				end
				return require("notify")(msg, ...)
			end
		end,
	},

	{
		"akinsho/bufferline.nvim",
		dependencies = "nvim-tree/nvim-web-devicons",
		config = function()
			require("plugins.bufferline")
		end,
	},

	{
		"nvim-lualine/lualine.nvim",
		dependencies = "nvim-tree/nvim-web-devicons",
		config = function()
			require("plugins.lualine")
		end,
		event = "VeryLazy",
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
		end,
	},

	{
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		config = function()
			require("plugins.indent-blankline")
		end,
	},

	--helps figure out what key to press next sometimes
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		init = function()
			vim.o.timeout = true
			vim.o.timeoutlen = 300
		end,
	},

	--gcc or gbc to
	{
		"numToStr/Comment.nvim",
		lazy = false,
		config = function()
			require("plugins.comment")
		end,
	},

	{ "tpope/vim-surround" }, -- Surround ysw), ysw", ysw], yswt
	{ "nvim-lua/plenary.nvim" },
	{ "nvim-tree/nvim-web-devicons", lazy = true },
	{ "ap/vim-css-color" },
	{ "mbbill/undotree" }, -- control u to bring up tree

	--auto pairs
	--TODO: move to use the windwp autopair plugin
	{
		"cohama/lexima.vim",
		event = "InsertEnter",
	},

	--auto close + rename html tags
	--TODO: make this work
	{
		"windwp/nvim-ts-autotag",
		-- event = "InsertEnter",
		config = function()
			require("nvim-treesitter.configs").setup({
				autotag = {
					enable = true,
					enable_rename = true,
					enable_close = true,
					enable_close_on_slash = true,
					filetypes = { "html", "xml" },
				},
			})
		end,
	},

	--start up menu
	{
		"goolord/alpha-nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		event = "VimEnter",
		config = function()
			require("plugins.alpha")
		end,
	},

	--multi line editing
	{
		"mg979/vim-visual-multi",
		branch = "master",
	},

	-- Copilot Stuff
	{
		"zbirenbaum/copilot.lua",
		cmd = "Copilot",
		event = "InsertEnter",
		config = function()
			require("plugins.copilot")
		end,
	},

	-- Turn copilot into a lsp completion source
	{
		"zbirenbaum/copilot-cmp",
		config = function()
			require("copilot_cmp").setup()
		end,
	},

	-- Syntax highlighting
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",

		--make commenting smarter
		--config in plugins.treesitter
		dependencies = {
			"JoosepAlviste/nvim-ts-context-commentstring",
		},

		config = function()
			require("plugins.treesitter")
		end,
	},

	-- LSP/autocomplete
	-- https://github.com/VonHeikemen/lsp-zero.nvim
	-- Run :LspInstall <language> to install language servers
	{
		"VonHeikemen/lsp-zero.nvim",
		branch = "v2.x",
		dependencies = {
			-- LSP Support
			{ "neovim/nvim-lspconfig" }, -- Required
			{ -- Optional
				"williamboman/mason.nvim",
				build = function()
					pcall(vim.api.nvim_command, "MasonUpdate")
				end,
			},
			{ "williamboman/mason-lspconfig.nvim" }, -- Optional

			-- Autocompletion
			{ "hrsh7th/nvim-cmp" }, -- Required
			{ "hrsh7th/cmp-nvim-lsp" }, -- Required
			{ "L3MON4D3/LuaSnip" }, -- Required
			{ "rafamadriz/friendly-snippets" },
		},
		config = function()
			require("plugins.lsp")
		end,
	},

	--lsp saga for extra lsp features
	{
		"nvimdev/lspsaga.nvim",
		dependencies = {
			{ "nvim-treesitter/nvim-treesitter" }, -- optional
			{ "nvim-tree/nvim-web-devicons" }, -- optional
		},
		config = function()
			require("plugins.lsp-saga")
		end,
	},

	--linting & formatting
	-- null is being deprecated at some point so need to switch to another plugin
	{
		"jose-elias-alvarez/null-ls.nvim",
		requires = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
		config = function()
			require("plugins.null-ls")
		end,
	},

	--use mason to install linters+formatters
	{
		"jay-babu/mason-null-ls.nvim",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			"williamboman/mason.nvim",
			"jose-elias-alvarez/null-ls.nvim",
		},
		config = function()
			require("plugins.mason-null-ls") -- require your null-ls config here (example below)
		end,
	},

	--astro support
	{
		"wuelnerdotexe/vim-astro",
		config = function()
			require("plugins.astro")
		end,
	},
})
