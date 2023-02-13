# 常用操作备忘录

## nvim
C + d 向下翻半页 C+u 向上翻半页
C + <- 和 C + -> 每次光标移动一个单词
C + g 获取当前编辑文件路径
:b [... buffers中的文件] 切换缓冲中打开的文件
:e 文件路径/文件名 切换编辑文件

<leader> 默认绑定的是 \ 键。

### telescope
<leader>ff 查询当前文件夹下的文件
<leader>fb 查询缓冲中的编辑文件
<leader>fg 在当前文件夹下查询字符串 注意需要安装 ripgrep (ubuntu下: sudo apt install ripgrep)
<leader>fh 根据关键字查找nvim下面可使用的命令 并且展示相关信息

## fzf
C-r 返回操作历史
C-t 返回当前文件夹下的文件
Alt-c  返回当前路径下的文件夹

## nvim-treesitter
- 打开代码折叠功能 normal zR

## tmux
C-a % 右侧新建pane
C-a " 下侧新建pane
C-a x 关闭pane
C-a & 关闭window
C-a Z 最大化当前Panel & 还原再次执行
C-a w 列出所有window
C-a l 跳到最后一个window
C-a q 显示所有Panel编号(在编号消失前 输入编号可以快速跳转光标)

## windows terminal
Alt-enter 全屏terminal 
[wsl 下 nvim 如何使用 剪贴板 官方解决方法](https://github.com/neovim/neovim/wiki/FAQ#how-to-use-the-windows-clipboard-from-wsl) 记得将其添加进入windows自带的virus & threat protection的不扫描文件夹路径中

## 待研究
two things: a) cmp is better than coq, b) they both kinda suck
nvim lsp already gives implementations of completefunc and omnfunc, and its really simple just to the same supertab behavior everyones been doing for the past 20 years

@RageCPP the tl;dr is "stop fighting vim", also put supertab and mucomplete in your notes
