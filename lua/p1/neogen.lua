local opts = { noremap = true, silent = true }
vim.api.nvim_set_keymap("n", "<Leader>gc", ":lua require('neogen').generate()<CR>", opts)
require('neogen').setup {
    enabled = true,
    languages = {
        python = {
            template = {
                annotation_convention = "numpydoc" -- for a full list of annotation_conventions, see supported-languages below,
                }
        },
    }
}
