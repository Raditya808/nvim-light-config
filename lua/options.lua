require "nvchad.options"

-- add yours here!

-- Configure some global Vim options tuned to reduce frequent event triggers
local o = vim.o

-- updatetime controls CursorHold and related autocmd frequency.
-- Increase to reduce how often plugins react to idle (try 1000-2000 ms).
o.updatetime = 1500

-- timeoutlen controls mapping timeout; keep reasonable for responsiveness
o.timeoutlen = 500

-- other personal options can go here
-- o.cursorlineopt = 'both' -- to enable cursorline!
