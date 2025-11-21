vim.filetype.add({
	extension = {
		astro = "astro",
	},
})

vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(args)
		local client = vim.lsp.get_client_by_id(args.data.client_id)
		if client.name == "rzls" then
			vim.api.nvim_create_autocmd("BufWritePost", {
				pattern = "*__virtual.*",
				callback = function()
					vim.bo.modifiable = true
					-- After update, optionally mark as non-modifiable again
					vim.defer_fn(function()
						vim.bo.modifiable = false
					end, 500)
				end,
			})
		end
	end,
})
