local cmp_status, cmp = pcall(require, "cmp")
if not cmp_status then
    vim.notify("nvim-cmp could not be loaded")
    return
end


local luasnip_status, luasnip = pcall(require, "luasnip")
if not luasnip_status then
    vim.notify("luasnip could not be loaded")
    return
end

--load friendly snippets
require("luasnip/loaders/from_vscode").lazy_load()

vim.opt.completeopt "menu,menuone,noselect"

cmp.setup({
    snippet {
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end,
    },

    mapping = cmp.mapping.present.insert({
        ["<C-k>"] = cmp.mapping.select_prev_item(), -- go down autocomplete menu
        ["<C-j>"] = cmp.mapping.select_next_item(), -- go up autocomplete menu
        ["<C-Space>"] = cmp.mapping.complete(), -- show suggestions
        ["<C-e>"] = cmp.mapping.close(), --close menu
        ["<CR>"] = cmp.mapping.confirm({ -- (control enter) - confirm selection
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
        }),
    }),

    source = cmp.config.sources({
        { name = "luasnip" }, --snippests
        { name = "buffer" }, --text within the buffer
        { name = "path" }, --files in the path
        { name = "nvim_lsp" }, --nvim lsp
    }),
})

