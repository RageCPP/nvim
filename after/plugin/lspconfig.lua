local lspconfig_status, lspconfig = pcall(require, 'lspconfig')
local cmp_nvim_lsp_status, cmp_nvim_lsp = pcall(require, 'cmp_nvim_lsp')
local status = lspconfig_status and cmp_nvim_lsp_status
if (not status) then return end

local capabilities = cmp_nvim_lsp.default_capabilities()
-- Enable some language servers with the additional completion capabilities offered by nvim-cmp
local servers = { 'clangd', 'cmake', 'lua_ls', "rust_analyzer", "tsserver" }
  for _, lsp in ipairs(servers) do
    lspconfig[lsp].setup {
      capabilities = capabilities
    }
end

-- clangd
lspconfig.clangd.setup {
  init_options = {
    fallbackFlags = { "-x", "c" },
  },
  filetypes = { "c", "h", "cpp", "objc", "objcpp", "cuda", "proto", "hpp" },
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