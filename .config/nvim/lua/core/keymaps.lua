vim.g.mapleader = " "

local keymap = vim.keymap -- for convenience


-- harpoon
keymap.set("n", "<leader>a", "<cmd>lua require('harpoon.mark').add_file()<cr>")
keymap.set("n", "<leader>e", "<cmd>lua require('harpoon.ui').toggle_quick_menu()<cr>")
keymap.set("n", "<leader>n", "<cmd>lua require('harpoon.ui').nav_next()<cr>")
keymap.set("n", "<leader>p", "<cmd>lua require('harpoon.ui').nav_prev()<cr>")


--neotree
keymap.set("n", "<leader>t", ":NeoTree<CR>")

--fzf
-- keymap.set("n", "\", ":Files<CR>")
