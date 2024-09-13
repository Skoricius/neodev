

return {
    {
        'VonHeikemen/lsp-zero.nvim',
        dependencies = {
            -- LSP Support
            'neovim/nvim-lspconfig',
            'williamboman/mason.nvim',
            'williamboman/mason-lspconfig.nvim',
            -- Autocompletion
            'hrsh7th/nvim-cmp',
            'hrsh7th/cmp-buffer',
            'hrsh7th/cmp-path',
            'saadparwaiz1/cmp_luasnip',
            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/cmp-nvim-lua',
            -- Snippets
            'L3MON4D3/LuaSnip',
            'rafamadriz/friendly-snippets',
        },
        config = function()
            local lsp = require("lsp-zero")



            local lsp_attach = function(client, bufnr)
                local opts = { buffer = bufnr, remap = false }

                lsp.format_on_save({
                    format_opts = {
                        async = false,
                        timeout_ms = 10000,
                    },
                    servers = {
                        ['pylsp'] = { 'python' },
                        ['rust_analyzer'] = { 'rust' },
                    }
                })
                local luasnip = require("luasnip")
                local cmp = require('cmp')
                local cmp_select = { behavior = cmp.SelectBehavior.Select }
                cmp.setup({
                    sources = {
                        {name = 'nvim_lsp'},
                    },
                    mapping = cmp.mapping.preset.insert({
                    ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
                    ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
                    ['<C-y>'] = cmp.mapping.confirm({ select = true }),
                    ['<Tab>'] = cmp.mapping.confirm({ select = true }),
                    ["<C-m>"] = cmp.mapping.complete(),
                    ["<C-e>"] = cmp.mapping.close(),
                    ["<Esc>"] = cmp.mapping.close(),
                    -- ["<CR>"] = cmp.config.disable, lsp
                    ["<Right>"] = cmp.mapping.confirm({
                        behavior = cmp.ConfirmBehavior.Replace,
                        select = true,
                    }),
                })
                })

                vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
                vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
                vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
                vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
                vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
                vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
                vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts)
                vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
                vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
                vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
               -- vim.keymap.set("i", "<C-a>", function() vim.lsp.buf.complete() end, opts)
                vim.keymap.set("n", "<leader>vh", function() vim.lsp.buf.signature_help() end, opts)
            end

            lsp.extend_lspconfig({
                sign_text = true,
                lsp_attach = lsp_attach,
                capabilities = require('cmp_nvim_lsp').default_capabilities(),
              })
              

            lsp.setup_servers({'pylsp', 'rust_analyzer'})
            require('mason').setup({})
            require('mason-lspconfig').setup({
                ensure_installed = { "lua_ls", "rust_analyzer", 'pylsp'},
              handlers = {
                function(server_name)
                  require('lspconfig')[server_name].setup({})
                end,
              },
            })
        end,
        enable = vim.g.vscode == nil
    },
}
