local ok, emmet = pcall(require, "emmet")

if not ok then
	vim.notify("emmet couldn't be loaded")
	return
end

--also using emmet language server
--config in ls.lua
