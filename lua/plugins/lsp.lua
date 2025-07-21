return {
	{
		"VonHeikemen/lsp-zero.nvim",
		dependencies = {
			-- LSP Support
			"neovim/nvim-lspconfig",
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			-- Autocompletion
			"hrsh7th/nvim-cmp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"saadparwaiz1/cmp_luasnip",
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-nvim-lua",
			-- Snippets
			"L3MON4D3/LuaSnip",
			"rafamadriz/friendly-snippets",
		},
		config = function()
			if vim.g.vscode == nil then
				local lsp = require("lsp-zero")

				local lsp_attach = function(client, bufnr)
					local opts = { buffer = bufnr, remap = false }

					lsp.format_on_save({
						format_opts = {
							async = false,
							timeout_ms = 10000,
						},
						servers = {
							["pylsp"] = { "python" },
							["rust_analyzer"] = { "rust" },
							["lua_ls"] = { "lua" },
							["clangd"] = {
								"c",
								"cpp",
								"objc",
								"objcpp",
								"cuda",
								"proto",
							},
						},
					})
					local luasnip = require("luasnip")
					local cmp = require("cmp")
					local cmp_select = { behavior = cmp.SelectBehavior.Select }
					cmp.setup({
						sources = {
							{ name = "nvim_lsp" },
						},
						mapping = cmp.mapping.preset.insert({
							["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
							["<C-n>"] = cmp.mapping.select_next_item(cmp_select),
							["<C-y>"] = cmp.mapping.confirm({ select = true }),
							["<Tab>"] = cmp.mapping.confirm({ select = true }),
							["<C-m>"] = cmp.mapping.complete(),
							["<C-e>"] = cmp.mapping.close(),
							["<Esc>"] = cmp.mapping.close(),
							["<CR>"] = cmp.mapping.confirm({ select = true }),
							["<Right>"] = cmp.mapping.confirm({
								behavior = cmp.ConfirmBehavior.Replace,
								select = true,
							}),
						}),
					})

					vim.keymap.set("n", "gd", function()
						vim.lsp.buf.definition()
					end, opts)
					vim.keymap.set("n", "K", function()
						vim.lsp.buf.hover()
					end, opts)
					vim.keymap.set("n", "<leader>vws", function()
						vim.lsp.buf.workspace_symbol()
					end, opts)
					vim.keymap.set("n", "<leader>vd", function()
						vim.diagnostic.open_float()
					end, opts)
					vim.keymap.set("n", "[d", function()
						vim.diagnostic.goto_next()
					end, opts)
					vim.keymap.set("n", "]d", function()
						vim.diagnostic.goto_prev()
					end, opts)
					vim.keymap.set("n", "<leader>vca", function()
						vim.lsp.buf.code_action()
					end, opts)
					vim.keymap.set("n", "<leader>vrr", function()
						vim.lsp.buf.references()
					end, opts)
					vim.keymap.set("n", "<leader>vrn", function()
						vim.lsp.buf.rename()
					end, opts)
					vim.keymap.set("i", "<C-h>", function()
						vim.lsp.buf.signature_help()
					end, opts)
					-- vim.keymap.set("i", "<C-a>", function() vim.lsp.buf.complete() end, opts)
					vim.keymap.set("n", "<leader>vh", function()
						vim.lsp.buf.signature_help()
					end, opts)
					vim.keymap.set("n", "<leader>f", function()
						vim.lsp.buf.format()
					end)
				end

				lsp.extend_lspconfig({
					sign_text = true,
					lsp_attach = lsp_attach,
					capabilities = require("cmp_nvim_lsp").default_capabilities(),
				})

				lsp.setup_servers({ "pylsp", "rust_analyzer" })
				require("mason").setup({})
				require("mason-lspconfig").setup({
					ensure_installed = { "lua_ls", "rust_analyzer", "pylsp" },
					-- handlers = {
					--     function(server_name)
					--         require('lspconfig')[server_name].setup({})
					--     end,
					-- },
				})
				local lua_opts = lsp.nvim_lua_ls()
				require("lspconfig").lua_ls.setup(lua_opts)

				local python_utils = require("utilities.python")
				require("lspconfig").pylsp.setup({
					on_init = function(client)
						if python_utils.is_poetry_installed() then
							local poetry_env = python_utils.get_poetry_project_path()
							if poetry_env then
								local pylint_args = string.format(
									"--init-hook='import sys; sys.path.append(\"%s\")'",
									python_utils.get_poetry_site_packages()
								)
								table.insert(client.config.settings.pylsp.plugins.pylint.args, pylint_args)
								client.notify("workspace/didChangeConfiguration", { settings = client.config.settings })
								return true
							end
						end
					end,
					settings = {
						pylsp = {
							plugins = {
								-- formatter options
								black = { enabled = true },
								-- linter options
								flake8 = { enabled = false },
								pylint = { enabled = true, args = {} },
								-- pycodestyle = {
								--     ignore = { 'E501' }, -- This is the Error code for line too long.
								--     maxLineLength = 100 -- This sets how long the line is allowed to be. Also has effect on formatter.
								-- },
								ruff = { enabled = false },
								pyflakes = { enabled = false },
								pycodestyle = { enabled = false },
								-- type checker
								pylsp_mypy = { enabled = true },
								-- auto-completion options
								jedi_completion = { fuzzy = true },
								-- import sorting
								pyls_isort = { enabled = true },
							},
						},
					},
				})
			end
		end,
		enable = vim.g.vscode == nil,
	},
}
