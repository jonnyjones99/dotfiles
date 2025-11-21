local harpoon = require("harpoon")
local k = require("util.customkey")
local opts = require("util.customkey").opts

harpoon:setup({
	settings = {
		save_on_toggle = true, -- Save state on window toggle
		mark_branch = true, --set harpoon marks per branch
	},
})

-- Append to Harpoon List
k.nmap({
	"<leader>a",
	function()
		harpoon:list():add()
	end,
	opts({ desc = "Append File to Harpoon" }),
})

-- Display Harpoon List
k.nmap({
	"<leader>e",
	function()
		harpoon.ui:toggle_quick_menu(harpoon:list())
	end,
	opts({ desc = "List Harpoon Files" }),
})

-- Go to Previous Harpoon File
k.nmap({
	"<leader>p",
	function()
		harpoon:list():prev({ ui_nav_wrap = true })
	end,
	opts({ desc = "Previous Harpoon File" }),
})

-- Go to Next Harpoon File
k.nmap({
	"<leader>n",
	function()
		harpoon:list():next({ ui_nav_wrap = true })
	end,
	opts({ desc = "Next Harpoon File" }),
})

-- Clear harpoon List
k.nmap({
	"<leader>ac",
	function()
		harpoon:list():clear()
	end,
	opts({ desc = "Clear Harpoon List" }),
})

-- Select Harpoon File from List (1-5)
-- for i = 1, 5 do
-- 	k.nmap({
-- 		string.format("<C-%s>", i),
-- 		function()
-- 			harpoon:list():select(i)
-- 		end,
-- 	})
-- end
