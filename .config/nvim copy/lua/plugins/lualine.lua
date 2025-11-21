local ok, lualine = pcall(require, "lualine")

if not ok then
	vim.notify("lualine could not be loaded")
	return
end

local icons = require("util.icons")

lualine.setup({
	options = {
		theme = "catppuccin",
		globalstatus = true,
		disabled_filetypes = { statusline = { "dashboard", "alpha", "NvimTree" } },
		component_separators = "",
	},
	sections = {
		lualine_a = { { "mode", right_padding = 2 } },
		lualine_b = { "branch" },
		lualine_c = {
			"%=", --[[ add your center compoentnts here in place of this comment ]]
		},
		lualine_x = { {
			"filename",
			path = 1,
			padding = { left = 1, right = 1 },
		} },
		lualine_y = { "filetype" },
		lualine_z = {
			{ "location", left_padding = 2 },
		},
	},
	inactive_sections = {
		lualine_a = { "filename" },
		lualine_b = {},
		lualine_c = {},
		lualine_x = {},
		lualine_y = {},
		lualine_z = { "location" },
	},
	tabline = {},
	extensions = {},
})
