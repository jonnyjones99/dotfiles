local lsp = require("lsp-zero")
lsp.preset("recommended")

require("mason").setup({
	registries = {
		"github:mason-org/mason-registry",
		"github:crashdummyy/mason-registry",
	},
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

		["gopls"] = {
			"go",
		},

		["templ"] = {
			"templ",
		},
	},
})

lsp.ensure_installed({
	"intelephense",
	-- "gopls",
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

lsp.configure("gopls", {
	on_attach = on_attach,
	cmd = { "gopls" },
	filetypes = { "go", "gomod" },
	--TAKE THIS FOR PHP USEFUL IN WORDPRESS PROJECTS
	-- root_dir = util.root_pattern("go.mod", ".git", "go.work"),
	settings = {
		gopls = {
			completeUnimported = true,
			usePlaceholders = true,
			analyses = {
				unusedparams = true,
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
		"templ",
		"go",
	},
})

--astro lsp
-- require("lspconfig").astro.setup({})

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

--remove these if javascript is being fucky
require("luasnip").filetype_extend("javascriptreact", { "html" })
require("luasnip").filetype_extend("javascript", { "javascriptreact" })
require("luasnip").filetype_extend("javascript", { "html" })

cmp.setup({
	--add a bordert to the autocomplete menu
	window = {
		completion = cmp.config.window.bordered(),
		documentation = cmp.config.window.bordered(),
	},
	--remove this if you want your autocomplete menu also showing when typing
	--toggle the autocomplete menu with control space
	--having this turned off allows snippets to work properly
	--think it's an issue with keybinds fighting with eachother
	-- completion = {
	-- 	autocomplete = false,
	-- },
	sources = {
		{ name = "nvim_lsp" },
		{ name = "copilot" },
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
	},
	experimental = {
		ghost_text = true,
	},
})

--https://neovim.discourse.group/t/how-to-show-diagnostics-on-hover/3830/2
-- Function to check if a floating dialog exists and if not
-- then check for diagnostics under the cursor
-- function OpenDiagnosticIfNoFloat()
-- 	for _, winid in pairs(vim.api.nvim_tabpage_list_wins(0)) do
-- 		if vim.api.nvim_win_get_config(winid).zindex then
-- 			return
-- 		end
-- 	end
-- 	-- THIS IS FOR BUILTIN LSP
-- 	vim.diagnostic.open_float(0, {
-- 		scope = "cursor",
-- 		focusable = false,
-- 		close_events = {
-- 			"CursorMoved",
-- 			"CursorMovedI",
-- 			"BufHidden",
-- 			"InsertCharPre",
-- 			"WinLeave",
-- 		},
-- 	})
-- end
--
-- -- Show diagnostics under the cursor when holding position
-- vim.api.nvim_create_augroup("lsp_diagnostics_hold", { clear = true })
-- vim.api.nvim_create_autocmd({ "CursorHold" }, {
-- 	pattern = "*",
-- 	command = "lua OpenDiagnosticIfNoFloat()",
-- 	group = "lsp_diagnostics_hold",
-- })
