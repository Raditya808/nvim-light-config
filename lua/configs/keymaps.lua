-- lua/configs/keymaps.lua

local keymap = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

-- =============================================================
-- NAVIGATION & GENERAL 
-- =============================================================
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

keymap("n", "<C-S>", ":wa<CR>", opts)
keymap("n", "<leader>q", ":q<CR>", opts)
keymap("n", "<leader>x", ":xa<CR>", opts)
keymap("n", "<leader>sc", ":nohlsearch<cr>", opts)

keymap("n", "<leader>a", "ggVG", opts) 
keymap("i", "kj", "<Esc>", opts)
keymap("n", ";", ":", { noremap = true, silent = false })

-- =============================================================
-- COPY & PASTE
-- =============================================================
vim.keymap.set("n", "<C-c>", '"+yy', opts)
vim.keymap.set("v", "<C-c>", '"+y', opts)
vim.keymap.set({ "n", "v" }, "<C-v>", '"+p', opts)
vim.keymap.set("i", "<C-v>", '<Esc>"+pa', opts)

-- =============================================================
-- BUFFER & TAB (DISESUAIKAN UNTUK NVCHAD)
-- =============================================================
keymap("n", "<TAB>", "<cmd>bn<CR>", opts)
keymap("n", "<S-TAB>", "<cmd>bp<CR>", opts)

keymap("n", "<leader>cb", "<cmd>lua require('nvchad.tabufline').close_buffer()<CR>", opts)

-- =============================================================
-- TERMINAL (DISESUAIKAN UNTUK NVCHAD)
-- =============================================================
-- NvChad sudah punya terminal bawaan (<leader>h atau <leader>v)

keymap("n", "<C-t>", "<cmd>lua require('nvchad.term').toggle({ pos = 'sp', id = 'htoggleTerm' })<CR>", opts)
keymap("t", "<C-t>", "<C-\\><C-n><cmd>lua require('nvchad.term').toggle({ pos = 'sp', id = 'htoggleTerm' })<CR>", opts)

-- =============================================================
-- PLUGINS (DISESUAIKAN UNTUK NVCHAD)
-- =============================================================
-- Ganti Neotree ke NvimTree (Bawaan NvChad)
keymap("n", "<leader>e", "<cmd>NvimTreeToggle<CR>", opts)

-- Telescope (Tetap sama karena pluginnya sama)
keymap("n", "<leader>ff", ":Telescope find_files<CR>", opts)
keymap("n", "<leader>fg", ":Telescope live_grep<CR>", opts)
keymap("n", "<leader>fb", ":Telescope buffers<CR>", opts)

-- =============================================================
-- DASHBOARD TOGGLE 
-- =============================================================
_G.toggle_dashboard = function()
    local ft = vim.bo.filetype
    if ft == "alpha" then
        vim.cmd("bwipeout!")
    else
        local has_alpha, _ = pcall(require, "alpha")
        if has_alpha then
            vim.cmd("tabnew | Alpha")
        else
            print("Alpha Dashboard not found")
        end
    end
end
vim.keymap.set("n", "<leader>h", "<cmd>lua toggle_dashboard()<CR>", opts)

-- =============================================================
-- UNDO + REDO new  
-- =============================================================
--
-- Ctrl + Z untuk Undo
vim.keymap.set("n", "<C-z>", "<cmd>undo<CR>", opts)
vim.keymap.set("i", "<C-z>", "<cmd>undo<CR>", opts)

-- Ctrl + Y untuk Redo
vim.keymap.set("n", "<C-y>", "<cmd>redo<CR>", opts)
vim.keymap.set("i", "<C-y>", "<cmd>redo<CR>", opts)

-- =============================================================
-- SUPER FAST SCROLL (Normal & Visual Mode)
-- =============================================================

-- Biar pergerakan satu-satu tapi nggak kerasa berat/delay
vim.opt.lazyredraw = true
vim.opt.ttyfast = true

-- Shortcut buat scroll layar (bukan kursor) biar tetep sinkron
vim.keymap.set({ "n", "v" }, "<C-e>", "3<C-e>", { desc = "Scroll down screen faster" })

-- PERBAIKAN: <C-y> diganti ke <C-u> agar tidak bentrok dengan tombol Redo di atas
vim.keymap.set({ "n", "v" }, "<C-u>", "3<C-y>", { desc = "Scroll up screen faster" })

-- Klik Esc 2 kali buat keluar dari terminal mode ke normal mode
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })
