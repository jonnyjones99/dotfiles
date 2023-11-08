local ok, alpha = pcall(require, "alpha")

if not ok then
	vim.notify("alpha could not be loaded")
	return
end

-- local function header()
-- 	local banner_small = {
-- 		"                                                           ",
-- 		"                                                           ",
-- 		"                                                           ",
-- 		"                                                           ",
-- 		"        /\\_/\\           ___                              ",
-- 		"       = o_o =_______    \\ \\             -JJ NVIM-       ",
-- 		"        __^      __(  \\.__) )                             ",
-- 		"    (@)<_____>__(_____)____/                               ",
-- 		"                                                           ",
-- 		"                                                           ",
-- 		"                                                           ",
-- 		"                                                           ",
-- 	}
-- 	return banner_small
-- end

local function header()
	local banner_small = {
		[[          ██  ████████  ██                          ]],
		[[          ████████████████                          ]],
		[[          ██████████████████                        ]],
		[[        ████  ████  ██████████                      ]],
		[[        ████████████████████████                    ]],
		[[        ██████    ██████████████████                ]],
		[[        ██  ██  ████  ████████████████████████████  ]],
		[[        ████        ████████████████████████        ]],
		[[        ████████████████████████████████████        ]],
		[[        ████████████████████████████████████        ]],
		[[        ████████████████████████████████████        ]],
		[[        ████████████████████████████████████        ]],
		[[        ██████████████████████████████████          ]],
		[[          ████████████████████████████████          ]],
		[[          ████    ████        ████    ████          ]],
		[[          ████    ████        ████    ████          ]],
		[[          ██      ██          ██      ██            ]],
	}
	return banner_small
end

-- Footer
local function footer()
	local version = vim.version()
	local print_version = "v" .. version.major .. "." .. version.minor .. "." .. version.patch
	local datetime = os.date("%Y/%m/%d %H:%M:%S")

	return {
		" ",
		print_version .. " - " .. datetime,
	}
end

local alpha = require("alpha")
local dashboard = require("alpha.themes.dashboard")

dashboard.section.header.val = header()
dashboard.section.footer.val = footer()

-- Menu
-- TODO: Add projects and Frecency?
dashboard.section.buttons.val = {
	dashboard.button("e", "  New file", ":ene <BAR> startinsert<CR>"),
	dashboard.button("\\", "  Find files"),
	dashboard.button("ctrl t", "󱠏  FileTree", "<cmd>NvimTreeOpen<CR>"),
	-- dashboard.button("LDR f t", "󰊄  Find text", "<cmd>Telescope live_grep<CR>"),
	-- dashboard.button("LDR f r", "󰔠  Recent files", "<cmd>Telescope oldfiles<CR>"),
	-- dashboard.button("LDR f p", "󱠏  Projects", "<cmd>Telescope projects<CR>"),
	-- dashboard.button("LDR p c", "  Config", "<cmd>e $MYVIMRC<CR>"),
	dashboard.button("-", "  Plugins", "<cmd>Lazy<CR>"),
	dashboard.button(":q", "  Quit", "<cmd>qa<CR>"),
}

alpha.setup(dashboard.config)
