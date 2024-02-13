local ok, mason_null_ls = pcall(require, "mason-null-ls")

if not ok then
	vim.notify("mason-null-ls could not be loaded")
	return
end

--require("mason-null-ls").setup({
--	ensure_installed = nil,
--	automatic_installation = true, -- You can still set this to `true`
--	handlers = {
--		-- Here you can add functions to register sources.
--		-- See https://github.com/jay-babu/mason-null-ls.nvim#handlers-usage
--		--
--		-- If left empty, mason-null-ls will  use a "default handler"
--		-- to register all sources
--	},
--})

mason_null_ls.setup({
	ensure_installed = {
		-- Opt to list sources here, when available in mason.
	},
	automatic_installation = false,
	handlers = {},
})
