if vim.g.vscode == nil then
    vim.keymap.set("n", "<leader>tf", "<cmd>ToggleTerm direction=float<cr>")
    vim.keymap.set("n", "<leader>th", "<cmd>ToggleTerm size=10 direction=horizontal<cr>")
    vim.keymap.set("n", "<leader>tv", "<cmd>ToggleTerm size=80 direction=vertical<cr>")
    vim.keymap.set("n", "<C-t>", "<cmd>ToggleTerm<cr>")
    vim.keymap.set("t", "<C-t>", "<cmd>ToggleTerm<cr>")
    vim.keymap.set("n", "<F7>", "<cmd>ToggleTerm<cr>")
    vim.keymap.set("t", "<F7>", "<cmd>ToggleTerm<cr>")

    vim.keymap.set('t', "<C-]>", "<C-\\><C-n>")
    vim.keymap.set('t', "<Esc>", "<Esc>")
    vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]])
    vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]])
    vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]])
    vim.keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]])
    vim.keymap.set('t', '<C-w>', [[<C-\><C-n><C-w>]])
end
