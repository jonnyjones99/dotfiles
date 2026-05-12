local ok = pcall(require, "notify")

if not ok then
	return
end

-- annoying hack to get rid of no lsp info message
-- See https://github.com/neovim/nvim-lspconfig/issues/1931#issuecomment-1297599534
-- An alternative solution: https://github.com/neovim/neovim/issues/20457#issuecomment-1266782345
local banned_messages = { "No information available" }

vim.notify = function(msg, ...)
	for _, banned in ipairs(banned_messages) do
		if msg == banned then
			return
		end
	end
	return require("notify")(msg, ...)
end
