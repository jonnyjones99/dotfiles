return {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.8',
    dependencies = { 
        'nvim-lua/plenary.nvim',
        "nvim-tree/nvim-web-devicons",
        { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' }
    },
    config = function()
        local telescope = require("telescope")
        local actions = require("telescope.actions")

        telescope.setup({
            defaults = {
                path_display = { "smart" },
            },
        })

        telescope.load_extension("fzf")

        --keymaps
        local keymap = vim.keymap
        local builtin = require('telescope.builtin')
        keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>", {})
        keymap.set("n", "<leader>fg", "<cmd>Telescope live_grep<cr>", {})
        keymap.set("n", "<leader>fb", builtin.buffers, {})
        keymap.set("n", "<leader>fh", builtin.help_tags, {})
        keymap.set("n", "<leader>fc", "<cmd>Telescope grep_string<cr>", {})
    end
}


