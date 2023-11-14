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
		additional_vim_regex_highlighting = { "php", "tsx", "ts", "js", "jsx", "astro" },
	},
	indent = {
		enable = false, -- Really breaks stuff if true
	},
	incremental_selection = {
		enable = true,
		keymaps = {
			init_selection = "gnn",
			node_incremental = "grn",
			scope_incremental = "grc",
			node_decremental = "grm",
		},
	},
	context_commentstring = {
		enable = true,
	},
	textsubjects = {
		enable = true,
		keymaps = {
			["<cr>"] = "textsubjects-smart",
		},
	},
	textobjects = {
		select = {
			enable = true,
			lookahead = true,
			keymaps = {
				["if"] = "@function.inner",
				["af"] = "@function.outer",
				["ia"] = "@parameter.inner",
				["aa"] = "@parameter.outer",
				["ac"] = "@comment.outer",
			},
		},
	},
})

local commentstringOK, ts_context_commentstring = pcall(require, "ts_context_commentstring")
if not commentstringOK then
	vim.notify("ts_context_commentstring could not be loaded")
	return
end

require("ts_context_commentstring").setup({})
