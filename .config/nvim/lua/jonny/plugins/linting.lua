return {
	"mfussenegger/nvim-lint",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local lint = require("lint")

		lint.linters_by_ft = {
			python = { "pylint" },
		}

		local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

		local function file_in_cwd(file_name)
			return vim.fs.find(file_name, {
				upward = true,
				stop = vim.loop.cwd():match("(.+)/"),
				path = vim.fs.dirname(vim.api.nvim_buf_get_name(0)),
				type = "file",
			})[1]
		end

		local function remove_linter(linters, linter_name)
			for k, v in pairs(linters) do
				if v == linter_name then
					linters[k] = nil
					break
				end
			end
		end

		local function linter_in_linters(linters, linter_name)
			for k, v in pairs(linters) do
				if v == linter_name then
					return true
				end
			end
			return false
		end

		local function remove_linter_if_missing_config_file(linters, linter_name, config_file_name)
			if linter_in_linters(linters, linter_name) and not file_in_cwd(config_file_name) then
				remove_linter(linters, linter_name)
			end
		end

		local function try_linting()
			local linters = lint.linters_by_ft[vim.bo.filetype]

			-- if linters then
			--   -- remove_linter_if_missing_config_file(linters, "eslint_d", ".eslintrc.cjs")
			--   remove_linter_if_missing_config_file(linters, "eslint_d", "eslint.config.js")
			-- end

			lint.try_lint(linters)
		end

		vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
			group = lint_augroup,
			callback = function()
				try_linting()
			end,
		})

		vim.keymap.set("n", "<leader>l", function()
			try_linting()
		end, { desc = "Trigger linting for current file" })

		-- Configure diagnostic virtual text (inline errors/warnings)
		-- This applies to both LSP diagnostics and linter diagnostics
		local diagnostics_enabled = true

		local function toggle_diagnostics()
			diagnostics_enabled = not diagnostics_enabled
			if diagnostics_enabled then
				vim.diagnostic.config({
					virtual_text = {
						spacing = 4,
						prefix = "●",
						severity = {
							min = vim.diagnostic.severity.HINT,
						},
					},
					signs = {
						text = {
							[vim.diagnostic.severity.ERROR] = "✗",
							[vim.diagnostic.severity.WARN] = "⚠",
							[vim.diagnostic.severity.INFO] = "ℹ",
							[vim.diagnostic.severity.HINT] = "➤",
						},
					},
					underline = true,
					update_in_insert = false,
				})
				vim.notify("Diagnostics enabled", vim.log.levels.INFO)
			else
				vim.diagnostic.config({
					virtual_text = false,
					signs = false,
					underline = false,
				})
				vim.notify("Diagnostics disabled", vim.log.levels.INFO)
			end
		end

		-- Initial diagnostic configuration
		vim.diagnostic.config({
			virtual_text = {
				spacing = 4,
				prefix = "●",
				severity = {
					min = vim.diagnostic.severity.HINT,
				},
			},
			signs = {
				-- Customize diagnostic signs using the new API
				text = {
					[vim.diagnostic.severity.ERROR] = "✗",
					[vim.diagnostic.severity.WARN] = "⚠",
					[vim.diagnostic.severity.INFO] = "ℹ",
					[vim.diagnostic.severity.HINT] = "➤",
				},
			},
			underline = true,
			update_in_insert = false,
		})

		-- Keybind to toggle diagnostics
		vim.keymap.set("n", "<leader>td", toggle_diagnostics, { desc = "Toggle diagnostics" })
	end,
}
