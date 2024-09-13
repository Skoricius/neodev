
    spec = {



    { "navarasu/onedark.nvim", disable = vscode_cond };
    {
        "folke/trouble.nvim",
        config = function()
            require("trouble").setup {
                icons = false,
                -- your configuration comes here
                -- or leave it empty to use the default settings
                -- refer to the configuration section below
            }
        end,
        disable = vscode_cond
    };
    { "theprimeagen/harpoon",
        disable = vscode_cond
    };
    "mbbill/undotree";
    { "nvim-treesitter/nvim-treesitter-context",
        disable = vscode_cond
    };


    { "laytan/cloak.nvim",
        disable = vscode_cond
    };
    {
        'cameron-wags/rainbow_csv.nvim',
        config = function()
            require 'rainbow_csv'.setup()
        end,
        -- optional lazy-loading below
        module = {
            'rainbow_csv',
            'rainbow_csv.fns'
        },
        ft = {
            'csv',
            'tsv',
            'csv_semicolon',
            'csv_whitespace',
            'csv_pipe',
            'rfc_csv',
            'rfc_semicolon'
        },
        cmd = {
            'RainbowDelim',
            'RainbowDelimSimple',
            'RainbowDelimQuoted',
            'RainbowMultiDelim'
        },
        disable = vscode_cond
    };
    --  docstringing
    {
        "danymat/neogen",
        config = function()
            require('neogen').setup {}
        end,
        -- Uncomment next line if you want to follow only stable versions
        -- tag = "*"
    };
    -- use {
    --     'rmagatti/auto-session',
    --     config = function()
    --         require("auto-session").setup {
    --             log_level = "error",
    --             pre_save_cmds = { 'Neotree close' },
    --             post_restore_cmds = { 'Neotree filesystem show' },
    --         }
    --     end,
    --     disable = vscode_cond
    -- }
    -- yanking over ssh
    {
        "ojroques/nvim-oscyank",
        disable = vscode_cond
    };
    {
        "folke/zen-mode.nvim",
        opts = {
            -- your configuration comes here
            -- or leave it empty to use the default settings
            -- refer to the configuration section below
        },
        disable = vscode_cond
    };
    -- Plugin for interactively running Python scripts
    -- use {
    --     "benlubas/molten-nvim",
    --     version = "^1.0.0", -- use version <2.0.0 to avoid breaking changes
    --     build = ":UpdateRemotePlugins",
    --     init = function()
    --         -- this is an example, not a default. Please see the readme for more configuration options
    --         vim.g.molten_output_win_max_height = 12
    --     end,
    -- }
    { 'Vigemus/iron.nvim', disable = vscode_cond };
    { "mfussenegger/nvim-dap", disable = vscode_cond };
    { "mfussenegger/nvim-dap-python", disable = vscode_cond };
    -- Testing
    {
        "nvim-neotest/neotest",
        requires = {
            "nvim-neotest/nvim-nio",
            "nvim-lua/plenary.nvim",
            "antoinemadec/FixCursorHold.nvim",
            "nvim-treesitter/nvim-treesitter",
        },
        disable = vscode_cond,
    };
    { "nvim-neotest/neotest-python",
        disable = vscode_cond,
    };
    {
        "sindrets/diffview.nvim",
        disable = vscode_cond,
    };
    { "rcarriga/nvim-dap-ui",
        config = function()
            require('dapui').setup({ })
        end,
        requires = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
        disable = vscode_cond
    },
}
})

