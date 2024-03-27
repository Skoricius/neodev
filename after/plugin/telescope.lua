if vim.g.vscode == nil then
    local builtin = require('telescope.builtin')
    vim.keymap.set('n', '<leader>ff', builtin.git_files, {})
    vim.keymap.set('n', '<leader>ls', require("telescope.builtin").lsp_document_symbols, {})
    vim.keymap.set('n', '<C-p>', "<Cmd>Telescope frecency workspace=CWD<CR> ", {})
    vim.keymap.set('n', '<leader>fs', builtin.live_grep, {})
    -- vim.keymap.set('n', '<leader>fs', function()
    --     builtin.grep_string({ search = vim.fn.input("Grep > ") })
    -- end)
    vim.keymap.set('n', '<leader>vh', builtin.help_tags, {})
    vim.api.nvim_create_autocmd("FileType", {
        pattern = "TelescopeResults",
        callback = function(ctx)
            vim.api.nvim_buf_call(ctx.buf, function()
                vim.fn.matchadd("TelescopeParent", "\t\t.*$")
                vim.api.nvim_set_hl(0, "TelescopeParent", { link = "Comment" })
            end)
        end,
    })

    local function filenameFirst(_, path)
        local tail = vim.fs.basename(path)
        local parent = vim.fs.dirname(path)
        if parent == "." then return tail end
        return string.format("%s\t\t%s", tail, parent)
    end

    require('telescope').setup {
        defaults = {
            git_worktrees = vim.g.git_worktrees,
            -- path_display = { "shorten" },
            sorting_strategy = "ascending",
            layout_config = {
                horizontal = { prompt_position = "top", preview_width = 0.55 },
                vertical = { mirror = false },
                width = 0.87,
                height = 0.80,
                preview_cutoff = 120,
            },
            path_display = filenameFirst,
        },
        frecency = {
            show_score = true,
            show_unindexed = true,
            ignore_patterns = { "*.git/*", "*/tmp/*" },
            disable_devicons = false,
        },
        -- pickers = {
        --     find_files = {
        --         path_display = filenameFirst,
        --     },
        --     git_files = {
        --         path_display = filenameFirst,
        --     },
        --     frecency = {
        --         path_display = filenameFirst,
        --     }
        -- }
    }
end
