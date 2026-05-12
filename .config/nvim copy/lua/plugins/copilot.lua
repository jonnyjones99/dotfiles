local ok, copilot = pcall(require, "copilot")

if not ok then
	vim.notify("copilot couldn't be loaded")
	return
end

require("copilot").setup({
	suggestion = { enabled = false },
	panel = { enabled = false },
})
