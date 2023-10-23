-- leader key is space
vim.g.mapleader = " "

local keymap = vim.keymap -- for convenience

-- harpoon
keymap.set("n", "<leader>a", "<cmd>lua require('harpoon.mark').add_file()<cr>")
keymap.set("n", "<leader>e", "<cmd>lua require('harpoon.ui').toggle_quick_menu()<cr>")
keymap.set("n", "<leader>n", "<cmd>lua require('harpoon.ui').nav_next()<cr>")
keymap.set("n", "<leader>p", "<cmd>lua require('harpoon.ui').nav_prev()<cr>")

-- nvim tree
keymap.set("n", "<C-t>", ":NvimTreeToggle<cr>", { silent = true })

-- fzf
-- \\ in this case just means \, but you use a \ as an escape char in lua
keymap.set("n", "\\", ":FzfLua files<cr>", { silent = true })

-- bufferline
-- keymap.set("n", "<C-l>", ":BufferLineCycleNext<CR>", { silent = true })
-- keymap.set("n", "<C-h>", ":BufferLineCyclePrev<CR>", { silent = true })
keymap.set("n", "<Tab>", "<Cmd>BufferLineCycleNext<CR>", {})
keymap.set("n", "<S-Tab>", "<Cmd>BufferLineCyclePrev<CR>", {})

-- undotree
keymap.set("n", "<C-u>", ":UndotreeToggle<CR>", { silent = true })

-- move lines up and down
-- keymap.set({ "n", "v" }, "<C-j>", ":m .-1", { silent = true })
-- keymap.set({ "n", "v" }, "<C-k>", ":m .+1", { silent = true })

-- delete all buffers except current one
-- https://stackoverflow.com/questions/4545275/vim-close-all-buffers-but-this-one
keymap.set("n", "<leader>-", ":%bd|e#|bd#<cr>", { silent = true })
