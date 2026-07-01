vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Exit built-in terminal (Esc is often swallowed by the shell or WezTerm).
vim.keymap.set("t", "<Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })
vim.keymap.set("t", "<C-[>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- Home/End: WezTerm + tmux send xterm CSI sequences; map them like Linux terminals.
if not vim.g.vscode then
    local function map_home_end(home, end_key)
        for _, mode in ipairs({ "n", "v", "x", "s", "o" }) do
            vim.keymap.set(mode, home, "0", { desc = "Start of line" })
            vim.keymap.set(mode, end_key, "$", { desc = "End of line" })
        end
        vim.keymap.set("i", home, "<C-o>0", { desc = "Start of line" })
        vim.keymap.set("i", end_key, "<C-o>$", { desc = "End of line" })
    end

    map_home_end("<Home>", "<End>")
    map_home_end("<Esc>[H", "<Esc>[F")
    map_home_end("<Esc>[1~", "<Esc>[4~")
    map_home_end("<Esc>OH", "<Esc>OF")
end
