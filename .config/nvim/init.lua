-- Set space as leader key
vim.g.mapleader = " "

-- For my setup lua files are found in the configure directory
-- setup neovim to find the lua files anywhere
package.path = package.path .. ';' ..  vim.fn.stdpath('config') .. "/?.lua" 

--Delcare all plugins that I require
local plugins = {
    "nvim-tree/nvim-web-devicons",
    "stevearc/oil.nvim",
    "folke/tokyonight.nvim",
    "folke/which-key.nvim",
    "williamboman/mason.nvim",
    -- "williamboman/mason-lspconfig.nvim",
    "neovim/nvim-lspconfig",
    "ibhagwan/fzf-lua",
    "saghen/blink.lib",
    "saghen/blink.cmp"
}

-- Add github to the plugins
for i = 1, #plugins do
    plugins[i] = "https://github.com/" .. plugins[i]
end

-- Add the plugins (causes them to download if they are not downloaded already"
vim.pack.add(plugins)

-- Init Mason
require("mason").setup()

-- Init Mason-LSPConfig
-- require("mason-lspconfig").setup({
--     ensure_installed = {"lua_ls", "clangd", "cmake", "bashls"},
-- })
--
local cmp = require("blink.cmp")
cmp.build():pwait()
cmp.setup({
    keymap = {
        preset = "super-tab",
        ["<C-Z>"] = { "accept", "fallback" },
    },
    appearance = {
        nerd_font_variant = "mono",
    },
    completion = {
        documentation = { auto_show = true },
    },
    sources = {
        default = { "lsp", "path", "buffer" }
    },
    fuzzy = { implementation = "prefer_rust_with_warning" },
}
)

require("fzf-lua").setup({
})

vim.cmd.colorscheme("tokyonight")

require("oil").setup({
    default_file_explorer = true,
    buf_options = {
        buflisted = false,
        bufhidden = "hide",
    },
    delete_to_trash = false,
    skip_confirm_for_simple_edits = true,
    view_options = {
        show_hidden = true,
        natural_order = "fast",
        case_insensitive = true,
    },
})

require("which-key").setup({
    preset = "helix"
})

require("config.options")
require("config.lsp")
require("config.keymaps")
require("config.filepatterns")
