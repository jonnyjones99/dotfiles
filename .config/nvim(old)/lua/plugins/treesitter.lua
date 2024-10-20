local ok, treesitter = pcall(require, "treesitter")

if not ok then
	vim.notify("treesitter could not be loaded")
	return
end

require("nvim-treesitter.configs").setup({
	-- To install additional languages, do: `:TSInstall <mylang>`. `:TSInstall maintained` to install all maintained
	ensure_installed = "maintained",
	sync_installed = true,
	highlight = {
		enable = true, -- This is a MUST
		-- additional_vim_regex_highlighting = {
		-- 	"php",
		-- 	"tsx",
		-- 	"ts",
		-- 	"js",
		-- 	"jsx",
		-- 	"astro",
		-- 	"tmpl",
		-- 	"templ",
		-- 	"go",
		-- 	"golang",
		-- },
	},
	indent = {
		enable = false, -- Really breaks stuff if true
	},
	-- incremental_selection = {
	-- 	enable = true,
	-- 	keymaps = {
	-- 		init_selection = "gnn",
	-- 		node_incremental = "grn",
	-- 		scope_incremental = "grc",
	-- 		node_decremental = "grm",
	-- 	},
	-- },
	context_commentstring = {
		enable = true,
	},
	-- textsubjects = {
	-- 	enable = true,
	-- 	keymaps = {
	-- 		["<cr>"] = "textsubjects-smart",
	-- 	},
	-- },
	-- autotag = {
	-- 	enable = true,
	-- 	enable_rename = true,
	-- 	enable_close = true,
	-- 	enable_close_on_slash = true,
	-- 	filetypes = { "html", "xml", "tsx", "jsx", "astro", "php", "typescriptreact", "typescript", "javascriptreact" },
	-- },
	-- textobjects = {
	-- 	select = {
	-- 		enable = true,
	-- 		lookahead = true,
	-- 		keymaps = {
	-- 			["if"] = "@function.inner",
	-- 			["af"] = "@function.outer",
	-- 			["ia"] = "@parameter.inner",
	-- 			["aa"] = "@parameter.outer",
	-- 			["ac"] = "@comment.outer",
	-- 		},
	-- 	},
	-- },
})

require("ts_context_commentstring").setup({})
