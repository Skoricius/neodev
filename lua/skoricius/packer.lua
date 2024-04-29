-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd.packadd('packer.nvim')
local vscode_cond = vim.g.vscode ~= nil
-- print("Vscode: ", vscode_cond)

return require('packer').startup(function(use)
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'

    use {
        'nvim-telescope/telescope.nvim', tag = '0.1.4',
        -- or                            , branch = '0.1.x',
        requires = { { 'nvim-lua/plenary.nvim' } },
        disable = vscode_cond
    }
    use {
        "nvim-telescope/telescope-frecency.nvim",
    }


    use { "catppuccin/nvim", as = "catppuccin", disable = vscode_cond }
    use({
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
    })

    use {
        'nvim-treesitter/nvim-treesitter',
        run = function()
            local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
            ts_update()
        end,
        disable = vscode_cond
    }
    use { "theprimeagen/harpoon",
        disable = vscode_cond
    }
    use({
        "kdheepak/lazygit.nvim",
        -- optional for floating window border decoration
        requires = {
            "nvim-lua/plenary.nvim",
        },
        disable = vscode_cond
    })
    use("mbbill/undotree")
    use { "nvim-treesitter/nvim-treesitter-context",
        disable = vscode_cond
    };

    use {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v1.x',
        requires = {
            -- LSP Support
            { 'neovim/nvim-lspconfig' },
            { 'williamboman/mason.nvim' },
            { 'williamboman/mason-lspconfig.nvim' },

            -- Autocompletion
            { 'hrsh7th/nvim-cmp' },
            { 'hrsh7th/cmp-buffer' },
            { 'hrsh7th/cmp-path' },
            { 'saadparwaiz1/cmp_luasnip' },
            { 'hrsh7th/cmp-nvim-lsp' },
            { 'hrsh7th/cmp-nvim-lua' },

            -- Snippets
            { 'L3MON4D3/LuaSnip' },
            { 'rafamadriz/friendly-snippets' },
        },
        disable = vscode_cond
    }
    use {
        "nvimdev/guard.nvim",
        -- Builtin configuration, optional
        requires = {
            { "nvimdev/guard-collection" },
        },
        disable = vscode_cond
    }

    use { "laytan/cloak.nvim",
        disable = vscode_cond
    }
    use {
        "ggandor/leap.nvim",
    }
    use {
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
    }
    use {
        'nvim-lualine/lualine.nvim',
        requires = { 'nvim-tree/nvim-web-devicons', opt = true },
        disable = vscode_cond
    }
    -- Side pane for file navigation
    use {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v3.x",
        requires = {
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
            "MunifTanjim/nui.nvim",
            -- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
        },
        opts = {
            auto_clean_after_session_restore = true,
        },
        disable = vscode_cond
    }
    use {
        'numToStr/Comment.nvim',
        config = function()
            require('Comment').setup({
                ---Add a space b/w comment and the line
                padding = true,
                ---Whether the cursor should stay at its position
                sticky = true,
            })
        end,
        disable = vscode_cond
    }
    use { "akinsho/toggleterm.nvim",
        tag = '*',
        config = function()
            require("toggleterm").setup()
        end,
        disable = vscode_cond
    }
    --  docstringing
    use {
        "danymat/neogen",
        config = function()
            require('neogen').setup {}
        end,
        -- Uncomment next line if you want to follow only stable versions
        -- tag = "*"
    }
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
    use {
        "ojroques/nvim-oscyank",
        disable = vscode_cond
    }
    use {
        "folke/zen-mode.nvim",
        opts = {
            -- your configuration comes here
            -- or leave it empty to use the default settings
            -- refer to the configuration section below
        },
        disable = vscode_cond
    }
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
    use { 'Vigemus/iron.nvim', disable = vscode_cond }
end)
