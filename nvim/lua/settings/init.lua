local set = vim.opt

set.expandtab = true
set.smarttab = true
set.shiftwidth = 4
set.tabstop = 4

set.hlsearch = true
set.incsearch = true
set.ignorecase = true
set.smartcase = true

set.splitbelow = true
set.splitright = true
set.wrap = true
set.scrolloff = 5

set.fileencoding = 'utf-8'
set.termguicolors = true
set.relativenumber = true
set.cursorline = true

set.hidden = true
set.laststatus = 2
set.cursorline = true
set.autoread = true

set.showcmd = true
set.smartindent = true
set.autoindent = true

vim.notify = require("notify") -- configuration for notifications
