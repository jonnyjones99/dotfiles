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
			theme = "ivy",
		},
		live_grep = {
			layout_strategy = "vertical",
		},
		buffers = { ignore_current_buffer = true },
	},
	defaults = {
		-- theme = "ivy",
		vimgrep_arguments = {
			"rg",
			"--no-heading",
			"--with-filename",
			"--line-number",
			"--column",
			"--smart-case",
			"--hidden",
			"--glob=!{.git,.svn,.hg,.DS_Store,thumbs.db,node_modules,bower_components}",
		},
		sort_mru = true,
		sorting_strategy = "ascending",
		color_devicons = true,
		layout_strategy = "horizontal",
		layout_config = {
			prompt_position = "top",
			horizontal = { width_padding = 0.04, height_padding = 0.1 },
			vertical = { width_padding = 0.05, height_padding = 1 },
		},
		border = true,
		prompt_prefix = "   ",
		hl_result_eol = false,
		wrap_results = true,
		hidden = true,
	},
})
