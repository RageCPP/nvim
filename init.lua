local o = vim.o
local g = vim.g

require("plugins")
require("lsp")
require("theme")
require("highlighting")

o.number = true
o.tabstop = 2
o.softtabstop = 0
o.shiftwidth = 2
o.expandtab = true
o.smartindent = true
o.swapfile = false

g.colors_name = "kanagawa"
g.background = "dark"
o.clipboard = "unnamedplus"
