local lspconfig_status, lspconfig = pcall(require, 'lspconfig')
local cmp_nvim_lsp_status, cmp_nvim_lsp = pcall(require, 'cmp_nvim_lsp')
local status = lspconfig_status and cmp_nvim_lsp_status
if (not status) then return end

local api = vim.api
local lsp_defaults = lspconfig.util.default_config
-- TODO: 疑问: after 文件夹下的文件会在每次打开 nvim 时候都运行一次么
lsp_defaults.capabilities = vim.tbl_deep_extend(
  'force',
  lsp_defaults.capabilities,
  cmp_nvim_lsp.default_capabilities()
)

-- Enable some language servers with the additional completion capabilities offered by nvim-cmp
local open_servers = { 'clangd', 'cmake', 'lua_ls', "rust_analyzer", "tsserver" }

for _, lsp in ipairs(open_servers) do
  lspconfig[lsp].setup({})
end

-- clangd
-- lspconfig.clangd.setup {
--   init_options = {
--     fallbackFlags = { "-x", "c" }, -- 设置只用c的标准，不是cpp或者object c的标准一起用
--   },
--   filetypes = { "c", "h"},
--   cmd = {
--     "clangd",
--     "--enable-config",
--     "--suggest-missing-includes",
--     "--background-index", -- 后台建立索引，并持久化到disk
--     "--clang-tidy", -- 开启clang-tidy
--     "--clang-tidy-checks=performance-*,bugprone-*",
--     "--completion-style=detailed",
--     "--cross-file-rename=true",
--     "--header-insertion=iwyu",
--     "--pch-storage=memory",
--     "--function-arg-placeholders=false",
--     "--ranking-model=decision_forest",
--     "--header-insertion-decorators",
--     "--pretty",
--     "--all-scopes-completion",
--   },
-- }

lspconfig.clangd.setup {
  filetypes = { "cpp", "objc", "objcpp", "cuda", "proto", "hpp" },
  cmd = {
    "clangd",
    "--enable-config",
    "--suggest-missing-includes",
    "--background-index", -- 后台建立索引，并持久化到disk
    "--clang-tidy", -- 开启clang-tidy
    "--clang-tidy-checks=performance-*,bugprone-*",
    "--completion-style=detailed",
    "--cross-file-rename=true",
    "--header-insertion=iwyu",
    "--pch-storage=memory",
    "--function-arg-placeholders=false",
    "--ranking-model=decision_forest",
    "--header-insertion-decorators",
    "--pretty",
    "--all-scopes-completion",
  },
}

api.nvim_create_autocmd('LspAttach', {
  callback = function (args)
    local keybind = function(mode, lhs, rhs)
      vim.keymap.set(mode, lhs, rhs, { buffer = args.buf })
    end

    keybind('n', '<F2>', '<cmd>lua vim.lsp.buf.rename()<cr>')
  end
})
