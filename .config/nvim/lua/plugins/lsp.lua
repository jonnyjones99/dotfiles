local lsp = require("lsp-zero")
lsp.preset("recommended")

require("mason").setup({
	ui = { border = "rounded" },
})

local on_attach = function()
	local opts = { buffer = 0 }
	vim.diagnostic.config({
		virtual_text = true,
	})

	-- vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
	vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
	vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
	vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
	vim.keymap.set("n", "<leader>dj", vim.diagnostic.goto_next, opts)
	vim.keymap.set("n", "<leader>dk", vim.diagnostic.goto_prev, opts)
	vim.keymap.set("n", "<leader>df", "<cmd>Telescope diagnostics<cr>", opts)
	vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
	vim.keymap.set("n", "<C-h>", vim.lsp.buf.signature_help, opts)
end

--format on save using null-ls
lsp.format_on_save({
	format_opts = {
		async = false,
		timeout_ms = 10000,
	},
	servers = {
		["null-ls"] = {
			"lua",
			"php",
			"css",
			"sass",
			"scss",
			"html",
			"intelephense",
			"typescript",
			"javascript",
			"typescriptreact",
			"javascriptreact",
			"astro",
		},

		["tsserver"] = {
			"typescript",
			"javascript",
			"typescriptreact",
			"javascriptreact",
			"astro",
		},

		["prettierd"] = {
			"html",
			"css",
			"scss",
			"sass",
			"astro",
		},

		["intelephense"] = {
			"php",
		},
	},
})

lsp.ensure_installed({
	"intelephense",
})

lsp.configure("intelephense", {
	on_attach = on_attach,

	--these stubs dont work for some reason :/
	settings = {
		intelephense = {
			stubs = {
				"bcmath",
				"bz2",
				"calendar",
				"Core",
				"curl",
				"zip",
				"zlib",
				"wordpress",
				"woocommerce",
				"acf-pro",
				"wordpress-globals",
				"wp-cli",
				"genesis",
				"polylang",
			},
			environment = {
				includePaths = {
					"~/.composer/vendor/php-stubs/",
					"~/Documents/Common Assets/PluginsStubs/",
				},
			},
			files = {
				maxSize = 5000000,
			},
		},
	},
})

lsp.configure("emmet_language_server", {
	on_attach = on_attach,
	filetypes = {
		"css",
		"eruby",
		"html",
		"javascript",
		"javascriptreact",
		"less",
		"sass",
		"scss",
		"svelte",
		"pug",
		"typescriptreact",
		"vue",
		"php",
	},
})

-- stop 'no information avilable' notification when using Hover
-- this only works in nightly build :(
-- leaving it here for now for when it's supported
-- doing a disgusting dirty hack in vimnotify.lua instead.

--[[

    vim.lsp.with(vim.lsp.handlers.hover, {
        silent = true,
    })

]]
--

--astro lsp
require("lspconfig").astro.setup({})

-- (Optional) Configure php language server for neovim
-- require("lspconfig").intelephense.setup(lsp.nvim_intelephense())

-- (Optional) Configure lua language server for neovim
require("lspconfig").lua_ls.setup(lsp.nvim_lua_ls())

lsp.setup()

---------------------
--auto complete stuff
---------------------
local cmp = require("cmp")
local cmp_action = require("lsp-zero").cmp_action()

require("luasnip.loaders.from_vscode").lazy_load() -- friendly snippets
require("luasnip.loaders.from_snipmate").lazy_load() -- nvim/snippets/{filetype}.snippets

cmp.setup({
	sources = {
		{ name = "copilot" },
		{ name = "nvim_lsp" },
		{ name = "luasnip" },
		{ name = "friendly-snippets" },
		{ name = "buffer", keyword_length = 3 },
		{ name = "path" },
	},
	mapping = {
		["<CR>"] = cmp.mapping.confirm({
			-- documentation says this is important.
			-- I don't know why.
			behavior = cmp.ConfirmBehavior.Replace,
			select = false,
		}),
		["<C-Space>"] = cmp.mapping.complete(),
		["<Tab>"] = cmp_action.luasnip_supertab(),
		["<S-Tab>"] = cmp_action.luasnip_shift_supertab(),
		-- ["<C-l>"] = cmp_action.luasnip_jump_forward(),
		-- ["<C-h>"] = cmp_action.luasnip_jump_backward(),
	},
	experimental = {
		ghost_text = true,
	},
})
