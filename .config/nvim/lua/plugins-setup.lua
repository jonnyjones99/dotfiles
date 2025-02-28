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
		"catppuccin/nvim",
		name = "catppuccin",
		lazy = false,
		priority = 1000,
		config = function()
			require("plugins.catppuccin")
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
			require("plugins.notify")
		end,
	},

	{
		"akinsho/bufferline.nvim",
		dependencies = "nvim-tree/nvim-web-devicons",
		after = "catppuccin",
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
		branch = "harpoon2",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		event = "VeryLazy",
		config = function()
			require("plugins.harpoon")
		end,
	},

	{
		"stevearc/oil.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			require("plugins.oil")
		end,
	},

	{
		"nvim-telescope/telescope.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			{
				"nvim-telescope/telescope-live-grep-args.nvim",
				version = "^1.0.0",
			},
		},
		tag = "0.1.5",
		config = function()
			require("plugins.telescope")
		end,
	},

	{
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		config = function()
			require("plugins.indent-blankline")
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
	-- {
	-- 	"zbirenbaum/copilot.lua",
	-- 	cmd = "Copilot",
	-- 	event = "InsertEnter",
	-- 	config = function()
	-- 		require("plugins.copilot")
	-- 	end,
	-- },

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
		-- event = "VeryLazy",

		-- dependencies = {
		-- 	"JoosepAlviste/nvim-ts-context-commentstring",
		-- 	"nvim-treesitter/nvim-treesitter-textobjects",
		-- 	"RRethy/nvim-treesitter-textsubjects",
		-- 	"windwp/nvim-ts-autotag",
		-- },

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

	-- --net
	{
		"seblj/roslyn.nvim",
		ft = { "cs", "razor" },
		opts = {
			filewatching = false,
		},
		dependencies = {
			{
				-- By loading as a dependencies, we ensure that we are available to set
				-- the handlers for roslyn
				"tris203/rzls.nvim",
				config = function()
					---@diagnostic disable-next-line: missing-fields
					require("rzls").setup({})
				end,
			},
		},
		config = function()
			require("roslyn").setup({
				args = {
					"--logLevel=Information",
					"--extensionLogDirectory=" .. vim.fs.dirname(vim.lsp.get_log_path()),
					"--razorSourceGenerator=" .. vim.fs.joinpath(
						vim.fn.stdpath("data") --[[@as string]],
						"mason",
						"packages",
						"roslyn",
						"libexec",
						"Microsoft.CodeAnalysis.Razor.Compiler.dll"
					),
					"--razorDesignTimePath=" .. vim.fs.joinpath(
						vim.fn.stdpath("data") --[[@as string]],
						"mason",
						"packages",
						"rzls",
						"libexec",
						"Targets",
						"Microsoft.NET.Sdk.Razor.DesignTime.targets"
					),
				},
				---@diagnostic disable-next-line: missing-fields
				config = {
					handlers = require("rzls.roslyn_handlers"),
					settings = {
						["csharp|inlay_hints"] = {
							csharp_enable_inlay_hints_for_implicit_object_creation = true,
							csharp_enable_inlay_hints_for_implicit_variable_types = true,

							csharp_enable_inlay_hints_for_lambda_parameter_types = true,
							csharp_enable_inlay_hints_for_types = true,
							dotnet_enable_inlay_hints_for_indexer_parameters = true,
							dotnet_enable_inlay_hints_for_literal_parameters = true,
							dotnet_enable_inlay_hints_for_object_creation_parameters = true,
							dotnet_enable_inlay_hints_for_other_parameters = true,
							dotnet_enable_inlay_hints_for_parameters = true,
							dotnet_suppress_inlay_hints_for_parameters_that_differ_only_by_suffix = true,
							dotnet_suppress_inlay_hints_for_parameters_that_match_argument_name = true,
							dotnet_suppress_inlay_hints_for_parameters_that_match_method_intent = true,
						},
						["csharp|code_lens"] = {
							dotnet_enable_references_code_lens = true,
						},
					},
				},
			})
		end,
		init = function()
			-- we add the razor filetypes before the plugin loads
			vim.filetype.add({
				extension = {
					razor = "razor",
					cshtml = "razor",
				},
			})
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
			require("plugins.mason-null-ls")
		end,
	},

	-- astro support
	{
		"wuelnerdotexe/vim-astro",
	},
})
