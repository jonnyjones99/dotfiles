return {
    'akinsho/bufferline.nvim',
    version = "*",
    dependencies = 'nvim-tree/nvim-web-devicons',
    config = function()
        require("bufferline").setup{
            options = {
                show_buffer_close_icons = false,
                show_close_icon = false,
                offsets = {
                    {
                        filetype = "NvimTree",
                        text = "File Explorer",
                        highlight = "Directory",
                        text_align = "left",
                    },
                },
            },
        }
        -- set keymaps
        local keymap = vim.keymap -- for conciseness
        keymap.set("n", "<Tab>", "<Cmd>BufferLineCycleNext<CR>", {})
        keymap.set("n", "<S-Tab>", "<Cmd>BufferLineCyclePrev<CR>", {})
    end
}

