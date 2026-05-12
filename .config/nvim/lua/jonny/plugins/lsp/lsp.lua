return {
	"hrsh7th/cmp-nvim-lsp",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		{ "antosha417/nvim-lsp-file-operations", config = true },
		{ "folke/lazydev.nvim", opts = {} },
		"neovim/nvim-lspconfig",
	},
	config = function()
		-- import cmp-nvim-lsp plugin
		local cmp_nvim_lsp = require("cmp_nvim_lsp")

		-- used to enable autocompletion (assign to every lsp server config)
		local capabilities = cmp_nvim_lsp.default_capabilities()

		-- Razor/Blazor and C# are handled by roslyn.nvim via cohosting (see roslyn.lua).
		-- csharp_ls is left out of the default to avoid double-attach with roslyn.
		vim.lsp.config("*", {
			capabilities = capabilities,
		})
	end,
}
