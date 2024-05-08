if vim.g.vscode == nil then
    vim.keymap.set("n", "<leader>Do", "<cmd>DiffviewOpen<cr>")
    vim.keymap.set("n", "<leader>Dc", "<cmd>DiffviewClose<cr>")
    vim.keymap.set("n", "<leader>Dh", "<cmd>DiffviewFileHistory %<cr>")
end
