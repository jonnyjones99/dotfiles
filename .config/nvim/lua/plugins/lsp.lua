local lsp = require("lsp-zero")
lsp.preset("recommended")

-- lsp.on_attach(function(client, bufnr)
-- 	-- see :help lsp-zero-keybindings
-- 	-- to learn the available actions
-- 	lsp.default_keymaps({ buffer = bufnr })
-- end)
--
--
local on_attach = function()
	local opts = { buffer = 0 }
	vim.diagnostic.config({
		virtual_text = true,
	})

	-- vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
	-- vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
	-- vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
	-- vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
	-- vim.keymap.set("n", "<leader>dj", vim.diagnostic.goto_next, opts)
	-- vim.keymap.set("n", "<leader>dk", vim.diagnostic.goto_prev, opts)
	-- vim.keymap.set("n", "<leader>df", "<cmd>Telescope diagnostics<cr>", opts)
	-- vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
	-- vim.keymap.set("n", "<C-h>", vim.lsp.buf.signature_help, opts)

	--accept completion with tab
end

--format on save using null-ls
lsp.format_on_save({
	format_opts = {
		async = false,
		timeout_ms = 10000,
	},
	servers = {
		["null-ls"] = { "javascript", "typescript", "lua", "php", "css", "sass", "html", "intelephense" },
	},
})

lsp.ensure_installed({
	"intelephense",
	-- "phpactor",
})

lsp.configure("intelephense", {
	on_attach = on_attach,
})

-- -- (Optional) Configure php language server for neovim
-- require("lspconfig").intelephense.setup(lsp.nvim_intelephense())
--
vim.api.nvim_create_autocmd({ "FileType" }, {
	pattern = "astro,php,css,eruby,html,htmldjango,javascriptreact,less,pug,sass,scss,svelte,typescriptreact,vue",
	callback = function()
		vim.lsp.start({
			cmd = { "emmet-language-server", "--stdio" },
			root_dir = vim.fs.dirname(vim.fs.find({ ".git" }, { upward = true })[1]),
			init_options = {
				--- @type table<string, any> https://docs.emmet.io/customization/preferences/
				preferences = {},
				--- @type "always" | "never" defaults to `"always"`
				showexpandedabbreviation = "always",
				--- @type boolean defaults to `true`
				showabbreviationsuggestions = true,
				--- @type boolean defaults to `false`
				showsuggestionsassnippets = false,
				--- @type table<string, any> https://docs.emmet.io/customization/syntax-profiles/
				syntaxprofiles = {},
				--- @type table<string, string> https://docs.emmet.io/customization/snippets/#variables
				variables = {},
				--- @type string[]
				excludelanguages = {},
			},
		})
	end,
})

-- (Optional) Configure lua language server for neovim
require("lspconfig").lua_ls.setup(lsp.nvim_lua_ls())

lsp.setup()
