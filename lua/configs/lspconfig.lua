-- Load default NvChad LSP helpers (if available)
pcall(require, "nvchad.configs.lspconfig")

local nvlsp = require "nvchad.configs.lspconfig"
local ok, lspconfig = pcall(require, "lspconfig")
if not ok then return end

-- Reduce diagnostic updates while inserting to avoid frequent UI updates
vim.diagnostic.config({ update_in_insert = false, virtual_text = false })

-- List of servers to setup
local servers = {
  "html", "cssls", "ts_ls", "clangd",
  "pyright", "jdtls", "rust_analyzer",
  "gopls", "intelephense", "emmet_ls"
}

for _, lsp in ipairs(servers) do
  local opts = {
    on_attach = nvlsp.on_attach,
    on_init = nvlsp.on_init,
    capabilities = nvlsp.capabilities,
  }

  -- Add debounce flag so LSP doesn't process every keystroke
  opts.flags = opts.flags or {}
  opts.flags.debounce_text_changes = 150 -- ms, adjust 100-300 as needed

  -- hypertext for html/emmet
  if lsp == "html" or lsp == "emmet_ls" then
    opts.filetypes = {
      "html", "python", "jinja.html", "htmldjango",
      "javascript", "typescript", "javascriptreact", "typescriptreact"
    }
  end

  -- pyright venv config
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

  -- Fix TypeScript/JavaScript auto-import/file completion issues and avoid file-kind completions
  if lsp == "ts_ls" then
    opts.settings = {
      typescript = { autoImportFileExcludePatterns = { "**/*" } },
      javascript = { autoImportFileExcludePatterns = { "**/*" } },
    }
    opts.handlers = {
      ["textDocument/completion"] = function(err, result, ctx, config)
        if result and result.items then
          for _, item in ipairs(result.items) do
            if item.kind == 1 then -- File kind completion
              item.insertText = nil
            end
          end
        end
        return result
      end
    }
  end

  -- Safe-guard: ensure server exists in lspconfig before calling setup
  if lspconfig[lsp] then
    lspconfig[lsp].setup(opts)
  end
end
