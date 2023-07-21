vim.g.mapleader = " "

local keymap = vim.keymap -- for convenience


-- harpoon
keymap.set("n", "<leader>a", "<cmd>lua require('harpoon.mark').add_file()<cr>")
keymap.set("n", "<leader>e", "<cmd>lua require('harpoon.ui').toggle_quick_menu()<cr>")
keymap.set("n", "<leader>n", "<cmd>lua require('harpoon.ui').nav_next()<cr>")
keymap.set("n", "<leader>p", "<cmd>lua require('harpoon.ui').nav_prev()<cr>")


--fzf
-- keymap.set("n", "\", ":Files<CR>")
--


-- nvim tree
vim.keymap.set("n", "<C-t>", ":NvimTreeToggle<cr>", { silent = true })

-- fzf
vim.keymap.set("n", "\\", ":FzfLua files<cr>", { silent = true })
