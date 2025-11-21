local ok, alpha = pcall(require, "alpha")
local dashboard = require("alpha.themes.dashboard")
local ascii_art = require("util.ascii-art")

if not ok then
	vim.notify("alpha could not be loaded")
	return
end

-- header
dashboard.section.header.val = ascii_art[math.random(#ascii_art)]
-- dashboard.section.header.opts.hl = "String"

-- Middle Buttons
-- TODO: Add projects
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
dashboard.section.footer.val = footer()

alpha.setup(dashboard.config)
