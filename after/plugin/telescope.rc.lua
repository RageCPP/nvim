local status, telescope = pcall(require, "telescope")

if (not status) then return end

local actions = require('telescope.actions')
local builtin = require("telescope.builtin")

telescope.setup {
  extensions = {
    fzf = {
      fuzzy = true,                    -- false will only do exact matching
      override_generic_sorter = true,  -- override the generic sorter
      override_file_sorter = true,     -- override the file sorter
      case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
                                       -- the default case_mode is "smart_case"
    }
  }
}
telescope.load_extension('fzf')


local function telescope_buffer_dir()
  return vim.fn.expand('%:p:h')
end

vim.keymap.set('n', ';f', function() builtin.find_files({no_ignore = true,hidden = true}) end)
vim.keymap.set('n', ';s', builtin.live_grep) -- 在您当前的工作目录中搜索一个字符串，并在您键入时实时获得结果，忽略.gitignore
vim.keymap.set('n', ';b', builtin.buffers)
vim.keymap.set('n', ';h', builtin.help_tags)
vim.keymap.set('n', ';r', builtin.resume) -- 恢复上次打开telescope的状态

voim.keymap.set('n', ';n', function() builtin.diagnostics({bufnr = 0}) end) -- 列出所有打开的缓冲区或特定缓冲区的诊断。使用bufnr=0当前缓冲区的选项。
vim.keymap.set('n', ';d', function() builtin.lsp_definitions({jumptype = "never"}) end)
