local ok, oil = pcall(require, "oil")

if not ok then
	vim.notify("oil could not be loaded")
	return
end

oil.setup({})
