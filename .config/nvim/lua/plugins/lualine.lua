local ok, lualine = pcall(require, "lualine")

if not ok then
	vim.notify("lualine could not be loaded")
	return
end

local icons = require("util.icons")

lualine.setup({
	-- options = {
	-- 	theme = "tokyonight",
	-- 	disabled_filetypes = { "NvimTree" },
	-- },

	options = {
		theme = "catppuccin",
		globalstatus = true,
		disabled_filetypes = { statusline = { "dashboard", "alpha", "NvimTree" } },
		component_separators = "",
		-- section_separators = { left = "", right = "" },
	},
	sections = {
		lualine_a = {
			{
				"mode",
				-- separator = { left = "", right = "" },
				right_padding = 2,
			},
		},
		lualine_b = {
			{ "branch" },
			{
				"diff",
				symbols = {
					added = icons.git.added,
					modified = icons.git.modified,
					removed = icons.git.removed,
				},
			},
		},
		lualine_c = {
			{
				"diagnostics",
				symbols = {
					error = icons.diagnostics.Error,
					warn = icons.diagnostics.Warn,
					info = icons.diagnostics.Info,
					hint = icons.diagnostics.Hint,
				},
			},
		},
		lualine_y = {},
		lualine_z = {
			{
				"filename",
				path = 1,
				padding = { left = 1, right = 1 },
			},
			{
				"filetype",
				icon_only = true,
				padding = { left = 1, right = 1 },
				color = { bg = "white" },
			},
		},
	},
})
