local ok, bufferline = pcall(require, "bufferline")

if not ok then
	vim.notify("bufferline couldn't be loaded")
	return
end

require("bufferline").setup({
	options = {
		themeable = "true",
		show_buffer_close_icons = false,
		show_close_icon = false,
		color_icons = true,
		--numbers= "ordinal",
		offsets = {
			{
				filetype = "NvimTree",
				text = "File Explorer",
				highlight = "Directory",
				text_align = "left",
			},
		},
	},
})
