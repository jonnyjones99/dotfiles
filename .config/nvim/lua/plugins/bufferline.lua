local ok, bufferline = pcall(require, "bufferline")

if not ok then
  vim.notify("bufferline couldn't be loaded")
  return
end

require('bufferline').setup {
    options = {
        show_buffer_close_icons = true,
        themeable = "true",
        --numbers= "ordinal",	
        offsets = {
            {
                filetype = "NvimTree",
                text = "File Explorer",
                highlight = "Directory",
                text_align = "left",
            },
        },
    }
}
