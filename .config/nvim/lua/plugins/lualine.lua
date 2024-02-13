local ok, lualine = pcall(require, "lualine")

if not ok then
	vim.notify("lualine could not be loaded")
	return
end

local icons = require("util.icons")

local function fg(name)
	return function()
		---@type {foreground?:number}?
		local hl = vim.api.nvim_get_hl_by_name(name, true)
		return hl and hl.foreground and { fg = string.format("#%06x", hl.foreground) }
	end
end

lualine.setup({
	-- options = {
	-- 	theme = "tokyonight",
	-- 	disabled_filetypes = { "NvimTree" },
	-- },

	options = {
		-- theme = "auto",
		theme = "tokyonight",
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
				-- separator = { left = "", right = "" },
				padding = { left = 1, right = 1 },
			},
			{
				"filetype",
				icon_only = true,
				-- separator = { right = "" },
				padding = { left = 1, right = 1 },
				color = { bg = "white" },
			},
		},
	},
})
