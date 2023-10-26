local ok, comment = pcall(require, "Comment")

if not ok then
	vim.notify("Comment.nvim could not be loaded")
	return
end

comment.setup()
