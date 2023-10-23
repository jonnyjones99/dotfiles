local ok, treesitter_autotag = pcall(require, "nvim-ts-autotag")

if not ok then
	vim.notify("nvim-ts-autotag could not be loaded")
	return
end

require("nvim-treesitter.configs").setup({
	autotag = {
		enable = true,
	},
})
