local status, tree = pcall(require, 'nvim-treesitter.configs')
if (not status) then return end
tree.setup {
  ensure_installed = {
    "c",              "lua",          "vim",
    "cpp",            "cmake",        "rust",
    "toml",           "typescript",   "tsx",
    "javascript",     "fish",         "scss",
    "css",            "proto",        "gitignore",
    "go",             "html",         "jsdoc",
    "json",           "python",       "sql",
    "regex",          "ini",          "bash",
    "astro"
  },
  sync_install = true,
  -- set to false if you don't have `tree-sitter` CLI installed locally. 
  -- `cargo install tree-sitter-cli` can install
  auto_install = true,
  autotag = { enable = true },
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
  ident = { enable = true }
}
local api = vim.api
local opt = vim.opt
api.nvim_create_autocmd(
  {'BufEnter','BufAdd','BufNew','BufNewFile','BufWinEnter'},
  {
    group = api.nvim_create_augroup('TS_FOLD_WORKAROUND', {}),
    callback = function()
      opt.foldmethod = 'expr'
      opt.foldexpr   = 'nvim_treesitter#foldexpr()'
    end
  }
)
-- https://vimhelp.org/fold.txt.html#fold-commands
-- zR Open all folds.
-- zc Close one fold under the cursor.
-- zC Close all folds under the cursor recursively.

-- local parser_config = require "nvim-treesitter.parsers".get_parser_configs()
-- parser_config.tsx.filetype_to_parsername = { "javascript", "typescript.tsx" }

