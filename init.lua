vim.g.base46_cache = vim.fn.stdpath "data" .. "/base46/"
vim.g.mapleader = " "
vim.deprecate = function() end

local function apply_ui_highlights()
  local hl_groups = {
    "IblChar",
    "IblWhitespace",
    "IblScopeChar",
    "IndentBlanklineChar",
  }
  for _, group in ipairs(hl_groups) do
    vim.api.nvim_set_hl(0, group, { fg = "#3b4261", nocombine = true })
  end

  local ui_groups = {
    "StatusLine",
    "StatusLineNC",
    "TabLine",
    "TabLineFill",
    "TabLineSel",
    "WinSeparator",
    "VertSplit",
    "BufferLineFill",
  }

  for _, group in ipairs(ui_groups) do
    local ok, _ = pcall(vim.api.nvim_get_hl, 0, { name = group, link = false })
    if ok then
      local link = group == "TabLineSel" and "PmenuSel" or "Normal"
      vim.api.nvim_set_hl(0, group, { link = link })
    end
  end

  local plugin_groups = {
    NvimTreeNormal = { link = "Normal" },
    NvimTreeNormalNC = { link = "NormalNC" },
    NvimTreeWinSeparator = { link = "WinSeparator" },
    NvimTreeCursorLine = { link = "CursorLine" },
    NvimTreeFolderName = { link = "Directory" },
    NvimTreeOpenedFolderName = { link = "Directory" },
    NvimTreeRootFolder = { link = "Title" },
    NvimTreeIndentMarker = { link = "Comment" },
    NvimTreeGitDirty = { link = "DiffChange" },
    NvimTreeGitNew = { link = "DiffAdd" },
    NvimTreeGitDeleted = { link = "DiffDelete" },
    NvimTreeOpenedFile = { link = "String" },
    NvimTreeSpecialFile = { link = "Special" },
    TelescopeBorder = { link = "FloatBorder" },
    TelescopePromptBorder = { link = "FloatBorder" },
    TelescopeResultsBorder = { link = "FloatBorder" },
    TelescopePreviewBorder = { link = "FloatBorder" },
    TelescopeSelection = { link = "PmenuSel" },
    TelescopeMatching = { link = "Search" },
    TelescopePromptPrefix = { link = "Identifier" },
    TelescopeTitle = { link = "Title" },
  }

  for group, spec in pairs(plugin_groups) do
    pcall(vim.api.nvim_set_hl, 0, group, spec)
  end
end

vim.api.nvim_create_autocmd({ "ColorScheme", "UIEnter", "BufEnter" }, {
  pattern = "*",
  callback = apply_ui_highlights,
})

vim.api.nvim_create_autocmd("BufEnter", {
  pattern = "*NvimTree*",
  callback = apply_ui_highlights,
})

vim.defer_fn(apply_ui_highlights, 100)


-- bootstrap lazy and all plugins
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"

if not vim.uv.fs_stat(lazypath) then
  local repo = "https://github.com/folke/lazy.nvim.git"
  vim.fn.system { "git", "clone", "--filter=blob:none", repo, "--branch=stable", lazypath }
end

vim.opt.rtp:prepend(lazypath)

local lazy_config = require "configs.lazy"

-- load plugins
require("lazy").setup({
  {
    "NvChad/NvChad",
    lazy = false,
    branch = "v2.5",
    import = "nvchad.plugins",
  },

  { import = "plugins" },
}, lazy_config)

-- load theme (cached base46 defaults/statusline)
dofile(vim.g.base46_cache .. "defaults")
dofile(vim.g.base46_cache .. "statusline")

require "options"
require "autocmds"

vim.schedule(function()
  require "mappings"

  -- to set up old keymaps in new neovim
  require "configs.keymaps"
end)
