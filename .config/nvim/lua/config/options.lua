vim.opt.expandtab = true -- convert tabs to spaces
vim.opt.shiftwidth = 3 -- Amount to indent with << and >>
vim.opt.tabstop = 3 -- how many spaces are show per Tab
vim.opt.softtabstop = 3 -- how many spaces are applied when pressing tab

vim.opt.smarttab = true
vim.opt.smartindent = false
vim.opt.cindent = true
vim.opt.autoindent = true

-- Enable break indent
vim.opt.breakindent = true

-- Visual
-- Line numbers
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.signcolumn = "yes"
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.scrolloff = 4 -- number screen lines to keep above and below the cursor
vim.opt.showmode = false

vim.opt.cursorline = true
vim.opt.termguicolors = true

-- Undos
vim.opt.undofile = true

-- Mouse mode
vim.opt.mouse = "a"

-- Searching
vim.opt.ignorecase = true
vim.opt.smartcase = true
