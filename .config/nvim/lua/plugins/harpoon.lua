local ok, harpoon = pcall(require, "harpoon")

if not ok then
	vim.notify("harpoon couldn't be loaded")
	return
end

require("harpoon").setup({
	menu = {
		width = vim.api.nvim_win_get_width(0) - 60,
	},
})
