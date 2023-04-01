local o = vim.o
local g = vim.g

require("plugins")
require("lsp")
require("theme")
require("highlighting")

local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})

require('lualine').setup()

o.number = true
o.tabstop = 2
o.softtabstop = 0
o.shiftwidth = 2
o.expandtab = true
o.smartindent = true
o.swapfile = false

g.colors_name = "kanagawa"
g.background = "dark"
