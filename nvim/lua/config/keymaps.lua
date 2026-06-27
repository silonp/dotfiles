vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Exit built-in terminal (Esc is often swallowed by the shell or WezTerm).
vim.keymap.set("t", "<Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })
vim.keymap.set("t", "<C-[>", "<C-\\><C-n>", { desc = "Exit terminal mode" })
