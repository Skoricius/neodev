if vim.g.vscode == nil then
    local ft = require('guard.filetype')

    local cwd = vim.fn.getcwd(-1, -1)
    local project_folder = cwd:match("/.*/(.*)")
    -- print(project_folder)
    -- Assuming you have guard-collection
    -- ft('python'):fmt('black')
    --     :append('isort')
    --     :lint('pylint')
    if project_folder == "qecf" then
        ft('python'):fmt('autopep8')
            :append('isort')
    else
        ft('python'):fmt('black')
            :append('isort')
    end
        -- :lint('pylint')

    -- Call setup() LAST!
    require('guard').setup({
        -- Choose to format on every write to a buffer
        fmt_on_save = true,
        -- Use lsp if no formatter was defined for this filetype
        lsp_as_default_formatter = false,
        -- By default, Guard writes the buffer on every format
        -- You can disable this by setting:
        -- save_on_fmt = false,
    })
end
