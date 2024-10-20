return {
    "scottmckendry/cyberdream.nvim",
    lazy = false,
    priority = 1000,
    config = function()
        require("cyberdream").setup({
            transparent = true,
            terminal_colors = true,
            cache = true,
            theme = {
                variant = "light", -- use "light" for the light variant. Also accepts "auto" to set dark or light colors based on the current value of `vim.o.background`
                saturation = 1, -- accepts a value between 0 and 1. 0 will be fully desaturated (greyscale) and 1 will be the full color (default)
            },

            extensions = {
                telescope = true,
            },
        });

        vim.cmd("colorscheme Cyberdream")

    end
}
