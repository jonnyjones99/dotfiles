
local ok, lualine = pcall(require, "lualine")

if not ok then
  vim.notify("lualine could not be loaded")
  return
end


require('lualine').setup {
	options = { theme = 'tokyonight' }
}
