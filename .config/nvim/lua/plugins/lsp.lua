local lsp = require("lsp-zero")
lsp.preset("recommended")

-- lsp.on_attach(function(client, bufnr)
-- 	-- see :help lsp-zero-keybindings
-- 	-- to learn the available actions
-- 	lsp.default_keymaps({ buffer = bufnr })
-- end)
--
require("mason").setup({
	ui = { border = "rounded" },
})

local on_attach = function()
	local opts = { buffer = 0 }
	vim.diagnostic.config({
		virtual_text = true,
	})

	vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
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
			"html",
			"intelephense",
			"typescript",
			"javascript",
			"typescriptreact",
			"javascriptreact",
		},

		["tsserver"] = {
			"typescript",
			"javascript",
			"typescriptreact",
			"javascriptreact",
		},

		["prettierd"] = {
			"php",
			"html",
		},
	},
})

lsp.ensure_installed({
	"intelephense",
})

lsp.configure("intelephense", {
	on_attach = on_attach,
})

-- (Optional) Configure php language server for neovim
-- require("lspconfig").intelephense.setup(lsp.nvim_intelephense())
--

-- (Optional) Configure lua language server for neovim
require("lspconfig").lua_ls.setup(lsp.nvim_lua_ls())

lsp.setup()

---------------------
--auto complete stuff
---------------------
local cmp = require("cmp")
local cmp_action = require("lsp-zero").cmp_action()

require("luasnip.loaders.from_vscode").lazy_load()

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
		["<Tab>"] = cmp_action.luasnip_supertab(),
		["<S-Tab>"] = cmp_action.luasnip_shift_supertab(),
	},

	--ensure first item in completion menu is selected
	preselect = "item",
	completion = {
		completeopt = "menu,menuone,noinsert",
	},
})
