-- roslyn.nvim creates a virtual HTML buffer for each .razor file via
-- vim.uri_to_bufnr() + nvim_buf_set_lines (see roslyn/razor/htmlDocument.lua).
-- Neither call fires BufRead, so Neovim's filetype detection never runs on
-- the buffer and `vim.lsp.enable("html")` won't auto-attach the html LSP.
-- That causes the cohost format flow to wait forever for an html response,
-- which surfaces as `[LSP][roslyn] timeout` on `:w` / `<leader>mp` in .razor
-- files. Setting filetype here lets the html LSP attach, which in turn lets
-- roslyn.nvim flip buftype to "nowrite" so `:q` stops warning about unsaved
-- changes for the virtual buffer.
vim.api.nvim_create_autocmd({ "BufAdd", "BufNew" }, {
	pattern = "*__virtual.html",
	callback = function(args)
		vim.bo[args.buf].filetype = "html"
	end,
})
