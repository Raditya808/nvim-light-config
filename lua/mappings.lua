require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "LSP Code Action" })
-- map({ "n", "x", "o" }, "s", "<Plug>(leap-forward)")
-- map({ "n", "x", "o" }, "S", "<Plug>(leap-backward)")
-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")

-- in insert mode, accept suggestion
map("i", "<C-l>", function()
  vim.fn.feedkeys(vim.fn["copilot#Accept"](), "")
end, { desc = "Copilot Accept", noremap = true, silent = true })
local opts = { silent = true, noremap = true, desc = "GitHub Copilot" }

-- Accept full suggestion
-- map("i", "<C-l>", 'copilot#Accept("<CR>")', { expr = true, replace_keycodes = false, desc = "Copilot Accept" })

-- Accept by word
map("i", "<C-j>", "copilot#AcceptWord()", { expr = true, replace_keycodes = false, desc = "Copilot Accept Word" })

-- Accept by line
map("i", "<C-k>", "copilot#AcceptLine()", { expr = true, replace_keycodes = false, desc = "Copilot Accept Line" })

-- Open Copilot Chat (requires GitHub Copilot Chat plugin)
map("n", "<leader>cc", ":Copilot chat<CR>", opts)
-- Selection mappings
local sel_opts = { noremap = true, silent = true }

-- Select all: Normal / Visual / Insert
map("n", "<C-a>", "ggVG", sel_opts)         -- Ctrl-A in normal: go to top, visual linewise to bottom
map("v", "<C-a>", "<Esc>ggVG", sel_opts)    -- Ctrl-A in visual: ensure full-file selection
map("i", "<C-a>", "<Esc>ggVG", sel_opts)    -- Ctrl-A in insert: exit insert then select all

-- Ctrl+Shift + Left/Right: expand selection by word
map("n", "<C-S-Left>", "vb", sel_opts)      -- start visual then move to previous word
map("n", "<C-S-Right>", "vw", sel_opts)     -- start visual then move to next word
map("v", "<C-S-Left>", "b", sel_opts)       -- in visual, move selection left by word
map("v", "<C-S-Right>", "w", sel_opts)      -- in visual, move selection right by word
map("i", "<C-S-Left>", "<Esc>vb", sel_opts) -- from insert: exit, start visual, move left by word
map("i", "<C-S-Right>", "<Esc>vw", sel_opts)

-- Ctrl+Shift + PageUp/PageDown: expand selection by page
map("n", "<C-S-PageUp>", "v<C-b>", sel_opts)    -- start visual then page-up
map("n", "<C-S-PageDown>", "v<C-f>", sel_opts)  -- start visual then page-down
map("v", "<C-S-PageUp>", "<C-b>", sel_opts)     -- in visual, page-up
map("v", "<C-S-PageDown>", "<C-f>", sel_opts)   -- in visual, page-down
map("i", "<C-S-PageUp>", "<Esc>v<C-b>", sel_opts)
map("i", "<C-S-PageDown>", "<Esc>v<C-f>", sel_opts)

-- Note: many terminals/GUI frontends do not send distinct codes for Ctrl+Shift+Arrow or Ctrl+Shift+Page keys.
-- If some mappings don't work, try a different terminal/GUI or choose alternative key combos.

-- Ctrl+Shift + Up/Down: expand selection by line (with Alt fallbacks)
-- Some terminals don't send <C-S-Up>/<C-S-Down>, so also map <A-Up>/<A-Down>
map("n", "<C-S-Up>", "vk", sel_opts)
map("v", "<C-S-Up>", "k", sel_opts)
map("i", "<C-S-Up>", "<Esc>vk", sel_opts)

map("n", "<C-S-Down>", "vj", sel_opts)
map("v", "<C-S-Down>", "j", sel_opts)
map("i", "<C-S-Down>", "<Esc>vj", sel_opts)

-- Alt (Meta) fallbacks
map("n", "<A-Up>", "vk", sel_opts)
map("v", "<A-Up>", "k", sel_opts)
map("i", "<A-Up>", "<Esc>vk", sel_opts)

map("n", "<A-Down>", "vj", sel_opts)
map("v", "<A-Down>", "j", sel_opts)
map("i", "<A-Down>", "<Esc>vj", sel_opts)