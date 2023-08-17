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

-- panel
-- c-w s 水平分割  c-w v 垂直分割
-- c-w + 高度增加  c-w - 高度减少 [可以输入 n 行]
-- c-w > 宽度增加  c-w < 宽度减少 [可以输入 n 列]
-- c-w _ 纵向扩展到最大  c-w | 横向扩展到最大 [可以输入 n 最大]
-- 移动窗口 c-w H 最左 c-w L 最右 c-w K 最上 c-w J 最下
-- c-w T 将窗口移动到标签页上面
-- c-w r 旋转当前窗口位置
-- c-w c 关闭窗口 

-- 光标
-- shift-$ 移动到行尾巴
-- shift-_ 移动到行首第一个非空格
-- 0 移动到行首
-- c-o 光标返回
-- c-i 光标往后跳
-- shift-a 移动到行尾并插入

-- 格式化
-- Visual 模式下 gq 格式化选中行 cpp项目使用 .clang-format 文件中的规则

