function MagmaInitPython()
    vim.cmd[[
    :MagmaInit python3
    :MagmaEvaluateArgument a=5
    ]]
end

vim.keymap.set("n", "<leader>mi", MagmaInitPython)
vim.keymap.set("n", "<leader>me", "<cmd>MagmaReevaluateCell<cr>")
vim.keymap.set("n", "<leader>ml", "<cmd>MagmaEvaluateLine<cr>")
vim.keymap.set("n", "<leader>md", "<cmd>MagmaDelete<cr>")
vim.keymap.set("n", "<leader>ms", "<cmd>MagmaShowOutput<cr>")
vim.keymap.set("n", "<leader>mo", "<cmd>MagmaEvaluateOperator<cr>")
vim.keymap.set("v", "<C-m>", "<cmd>MagmaEvaluateVisual<cr>")
