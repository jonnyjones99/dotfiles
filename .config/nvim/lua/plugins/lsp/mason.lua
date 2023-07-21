local mason_status, mason = pcall(require, "mason")
if not mason_status then
    vim.notify("mason could not be loaded")
    return
end


local mason_lspconfig_status, mason_lspconfig = pcall(require, "mason.lspconfig")
if not mason_lspconfig_status then
    vim.notify("mason.lspconfig could not be loaded")
    return
end


mason.setup()

mason.lspconfig.setu({
    ensure_installed = {
        "tsserver",
        "cssmodules_ls",
        "tailwindcss",
        "html",
        "jsonls",
        "sumneko_lua",
        "pyright",
        "intelephense",
        --if you ever need anymore full list is here:
        --https://github.com/williamboman/mason-lspconfig.nvim
    }
})
