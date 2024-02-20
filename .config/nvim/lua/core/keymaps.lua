-- leader key is space
vim.g.mapleader = " "

local keymap = vim.keymap -- for convenience

--VIM Specific Keybinds
--better save
keymap.set("n", "<leader>w", ":w<CR>")

-- easy escape in insert mode
keymap.set("i", "jj", "<ESC>", { silent = true })

--move line up and down
keymap.set("v", "J", ":m '>+1<CR>gv=gv")
keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- delete all buffers except current one
-- https://stackoverflow.com/questions/4545275/vim-close-all-buffers-but-this-one
keymap.set("n", "<leader>-", ":%bd|e#|bd#<cr>", { silent = true })

--restart lsp servers
keymap.set("n", "<leader><Bs>", ":LspRestart<cr>")

-------------------------------------------------------------------------------------------------------------------------
--PLUGIN KEYBINDS:
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

--bufferline
keymap.set("n", "<Tab>", "<Cmd>BufferLineCycleNext<CR>", {})
keymap.set("n", "<S-Tab>", "<Cmd>BufferLineCyclePrev<CR>", {})

-- undotree
keymap.set("n", "<C-u>", ":UndotreeToggle<CR>", { silent = true })

-- toggle between tabwidth of 2 and 4
vim.keymap.set("n", "<leader>tw", function()
	if vim.bo.tabstop == 2 then
		vim.bo.tabstop = 4
		vim.bo.shiftwidth = 4
		vim.bo.softtabstop = 4
	else
		vim.bo.tabstop = 2
		vim.bo.shiftwidth = 2
		vim.bo.softtabstop = 2
	end
end)

--[[
--
-- lsp/auto complete keymaps can be found in '/lsp.lua'
--
--]]

-- oil
vim.keymap.set("n", "<leader>t", "<cmd>lua require('oil').toggle_float()<CR>", { desc = "Oil" })
