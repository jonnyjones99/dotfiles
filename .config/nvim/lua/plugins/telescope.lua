local ok, telescope = pcall(require, "telescope")

if not ok then
	vim.notify("telescope couldn't be loaded")
	return
end

telescope.setup({})

telescope.load_extension("live_grep_args")
