return {
	"scottmckendry/cyberdream.nvim",
	lazy = false,
	priority = 1000,
	config = function()
		require("cyberdream").setup({
			variant = "dark",
			transparent = true,
			italic_comments = true,

			-- Replace all fillchars with ' ' for the ultimate clean look
			hide_fillchars = false,

			-- Apply a modern borderless look to pickers like Telescope, Snacks Picker & Fzf-Lua
			borderless_pickers = false,

			-- Improve start up time by caching highlights. Generate cache with :CyberdreamBuildCache and clear with :CyberdreamClearCache
			cache = true,

			-- Disable or enable colorscheme extensions
			extensions = {
                alpha = true,
                lazy = true,
                indentblankline = true,
			    telescope = true,
			    notify = true,
			    mini = true,
			    treesitter = true, -- Enable treesitter highlighting support
			},
		})

		vim.cmd("colorscheme cyberdream")
	end
}
