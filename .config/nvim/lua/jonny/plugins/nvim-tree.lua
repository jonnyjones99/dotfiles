return {
  "nvim-tree/nvim-tree.lua",
  version = "*",
  lazy = false,
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  config = function()
    vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1

    require("nvim-tree").setup {
        view = {
            side = "right",
            width = {},
        },
        renderer = {
            highlight_git = true,
            indent_markers = {
                enable = true,
                inline_arrows = false,
            },
            icons = {
                show = { folder_arrow = false },
                symlink_arrow = " 󰁔 ",
                glyphs = {
                    bookmark = "󰆤",
                    modified = "",
                    folder = {
                        symlink = "",
                        symlink_open = "",
                    },
                },
                git = {
                    unstaged = "M",
                    staged = "A",
                    unmerged = "UM",
                    renamed = "R",
                    untracked = "U",
                    deleted = "D",
                    ignored = "I",
                },
            },
        },
        modified = { enable = true },
        actions = {
            open_file = {
                quit_on_open = true,
            },
        }
    }
  end,
}
