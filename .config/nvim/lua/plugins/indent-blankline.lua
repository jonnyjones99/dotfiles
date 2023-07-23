
local ok, indent_blankline = pcall(require, "indent_blankline")

if not ok then
  vim.notify("indent-blankline couldn't be loaded")
  return
end

vim.opt.list = true
-- vim.opt.listchars:append "eol:↴"

require("indent_blankline").setup {
    show_current_context = true,
    show_current_context_start = true,
    show_end_of_line = true,
}
