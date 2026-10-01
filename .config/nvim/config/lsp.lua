vim.lsp.enable({ "clangd" })
vim.lsp.enable({ "neocmake" })


vim.lsp.config('lua_ls', {
    cmd = {'lua-language-server'},
    codelens = {enable = true},
    filetypes = {'lua'},
    single_file_support = true,
    root_markers = {'.luarc.json', '.git'},
    settings = {
        Lua = {
        format = { 
            enable = true, 
            defaultConfig = {
                indent_style = "space",
                indent_size = "4",
            },
        },
        runtime = {
            verion = 'LuaJIT',
            path = {
                'lua/?.lua',
                'lua/?/init.lua',
            },
        },
        workspace = { 
            checkThirdParty = false,
            library = {
                vim.env.VIMRUNTIME,
                vim.api.nvim_get_runtime_file("lua/lspconfig",false)[1],
		vim.fn.stdpath('config') .. '/config',
            },
        }
    },
}
})




vim.lsp.enable({ "lua_ls" })
vim.lsp.enable({ "bashls" })

