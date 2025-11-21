local ok, bufferline = pcall(require, "bufferline")

if not ok then
	vim.notify("bufferline couldn't be loaded")
	return
end

bufferline.setup({
	options = {
		themeable = "true",
		highlights = require("catppuccin.groups.integrations.bufferline").get(),
		show_buffer_close_icons = false,
		show_close_icon = false,
		-- color_icons = false,
		offsets = {
			{
				filetype = "NvimTree",
				text = "File Explorer",
				highlight = "Directory",
				text_align = "left",
			},
		},
		custom_filter = function(buf_number)
			local buf_name = vim.fn.bufname(buf_number)
			-- Exclude virtual files (e.g., '__virtual.html', '__virtual.cs')
			if buf_name:match("__virtual%.") then
				return false
			end
			return true
		end,
	},
})
