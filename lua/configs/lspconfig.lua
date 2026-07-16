-- 1. Load default NvChad
pcall(require, "nvchad.configs.lspconfig")

local nvlsp = require "nvchad.configs.lspconfig"
local ok, lspconfig = pcall(require, "lspconfig")

if not ok then return end

-- 2. language without ruff support 
local servers = { 
  "html", "cssls", "ts_ls", "clangd", 
  "pyright", "jdtls", "rust_analyzer", 
  "gopls", "intelephense", "emmet_ls" 
}

-- 3. Looping Setup
for _, lsp in ipairs(servers) do
  local opts = {
    on_attach = nvlsp.on_attach,
    on_init = nvlsp.on_init,
    capabilities = nvlsp.capabilities,
  }

  -- hypertext untuk Flask (Python) DAN JavaScript/TypeScript (innerHTML)
  if lsp == "html" or lsp == "emmet_ls" then
    opts.filetypes = { 
      "html", "python", "jinja.html", "htmldjango",
      "javascript", "typescript", "javascriptreact", "typescriptreact" -- <-- Tambah ini di sini
    }
  end

  -- Konfigurasi Python venv untuk pyright
  if lsp == "pyright" then
    opts.settings = {
      python = {
        pythonPath = vim.env.VIRTUAL_ENV and (vim.env.VIRTUAL_ENV .. "/bin/python") or "python",
        venvPath = ".",
        analysis = {
          extraPaths = vim.env.VIRTUAL_ENV and { vim.env.VIRTUAL_ENV .. "/lib/python3.*/site-packages" } or {},
        }
      }
    }
  end

  lspconfig[lsp].setup(opts)
end