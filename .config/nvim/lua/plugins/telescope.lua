local ok, telescope = pcall(require, "telescope")

if not ok then
	vim.notify("telescope couldn't be loaded")
	return
end

telescope.setup({
	pickers = {
		colorscheme = { enable_preview = true },
		find_files = {
			find_command = { "fd", "--type", "f", "--hidden", "--ignore-file", ".gitignore", "--strip-cwd-prefix" },
		},
		live_grep = {
			layout_strategy = "vertical",
		},
		buffers = { ignore_current_buffer = true },
	},
	extensions_list = { "themes", "terms" },
})
