require("plugins")
require("theme")

local o = vim.o
local g = vim.g
local cmd = vim.cmd
g.colors_name = "kanagawa"
g.background = "dark"
o.number = true
o.relativenumber = true
o.tabstop = 2
o.softtabstop = 0
o.shiftwidth = 2
o.expandtab = true
o.smartindent = true
o.swapfile = true
o.clipboard = "unnamedplus"
o.cursorline = true
o.termguicolors = true
o.winblend = 0 -- 浮动窗口透明
o.pumblend = 5 -- 也是透明度
o.wildoptions = 'pum' -- 模糊匹配 没有仔细看 TODO

-- https://www.reddit.com/r/neovim/comments/suy5j7/highlight_yanked_text/
-- highlight yanked text for 200ms using the "Visual" highlight group
cmd [[
  augroup highlight_yank
  autocmd!
  au TextYankPost * silent! lua vim.highlight.on_yank({higroup="Visual", timeout=100})
  augroup END
]]

