local ok, null_ls = pcall(require, "null-ls")

if not ok then
	vim.notify("null-ls could not be loaded")
	return
end

local formatting = null_ls.builtins.formatting

local sources = {
	formatting.prettierd,
	formatting.stylua,
	formatting.eslint_d,
	formatting.phpcbf,
}

-- use following command in vim to check executables are installed
-- :echo executable('prettierd')
-- 1 if installed 0 if not

null_ls.setup({
	sources = sources,
})

--format on save setup in lsp.lua
