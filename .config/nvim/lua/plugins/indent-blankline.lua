local ok, indent_blankline = pcall(require, "ibl")

if not ok then
	vim.notify("indent-blankline couldn't be loaded")
	return
end

indent_blankline.setup({})
