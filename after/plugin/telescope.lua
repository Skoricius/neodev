if vim.g.vscode == nil then
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>ls', require("telescope.builtin").lsp_document_symbols, {})
vim.keymap.set('n', '<C-p>', builtin.git_files, {})
vim.keymap.set('n', '<leader>fs', builtin.live_grep, {})
-- vim.keymap.set('n', '<leader>fs', function()
--     builtin.grep_string({ search = vim.fn.input("Grep > ") })
-- end)
vim.keymap.set('n', '<leader>vh', builtin.help_tags, {})
require('telescope').setup {
    defaults = {
        git_worktrees = vim.g.git_worktrees,
        path_display = { "truncate" },
        sorting_strategy = "ascending",
        layout_config = {
            horizontal = { prompt_position = "top", preview_width = 0.55 },
            vertical = { mirror = false },
            width = 0.87,
            height = 0.80,
            preview_cutoff = 120,
        },
    },
}
end
