return {
	-- Mason: installs LSP servers
	{
		"williamboman/mason.nvim",
		event = "BufReadPre",
		config = function()
			require("mason").setup({})
		end,
		enabled = vim.g.vscode == nil,
	},

	-- mason-lspconfig: bridges mason with Neovim's built-in LSP
	{
		"williamboman/mason-lspconfig.nvim",
		event = "BufReadPre",
		dependencies = {
			"neovim/nvim-lspconfig",
			"williamboman/mason.nvim",
			"hrsh7th/cmp-nvim-lsp",
		},
		config = function()
			-- Give all servers nvim-cmp capabilities
			vim.lsp.config("*", {
				capabilities = require("cmp_nvim_lsp").default_capabilities(),
			})

			-- pylsp: full settings (replaces require("lspconfig").pylsp.setup)
			local python_utils = require("utilities.python")
			vim.lsp.config("pylsp", {
				on_init = function(client)
					python_utils.is_poetry_installed(function(installed)
						if not installed then return end
						python_utils.get_poetry_project_path(function(poetry_env)
							if not poetry_env then return end
							python_utils.get_poetry_site_packages(function(site_packages)
								if not site_packages then return end
								local pylint_args = string.format(
									"--init-hook='import sys; sys.path.append(\"%s\")'",
									site_packages
								)
								table.insert(
									client.config.settings.pylsp.plugins.pylint.args,
									pylint_args
								)
								client.notify(
									"workspace/didChangeConfiguration",
									{ settings = client.config.settings }
								)
							end)
						end)
					end)
				end,
				settings = {
					pylsp = {
						plugins = {
							black           = { enabled = true },
							flake8          = { enabled = false },
							pylint          = { enabled = true, args = {} },
							ruff            = { enabled = false },
							pyflakes        = { enabled = false },
							pycodestyle     = { enabled = false },
							pylsp_mypy      = { enabled = true },
							jedi_completion = { fuzzy = true },
							pyls_isort      = { enabled = true },
						},
					},
				},
			})

			-- Auto-enable every server mason-lspconfig knows about
			require("mason-lspconfig").setup({
				ensure_installed = { "lua_ls", "rust_analyzer", "pylsp" },
				handlers = {
					function(server_name)
						vim.lsp.enable(server_name)
					end,
				},
			})
		end,
		enabled = vim.g.vscode == nil,
	},

	-- Completion
	{
		"hrsh7th/nvim-cmp",
		event = "InsertEnter",
		dependencies = {
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"saadparwaiz1/cmp_luasnip",
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-nvim-lua",
			"L3MON4D3/LuaSnip",
			"rafamadriz/friendly-snippets",
		},
		config = function()
			local cmp = require("cmp")
			local cmp_select = { behavior = cmp.SelectBehavior.Select }
			cmp.setup({
				sources = {
					{ name = "nvim_lsp" },
				},
				mapping = cmp.mapping.preset.insert({
					["<C-p>"]   = cmp.mapping.select_prev_item(cmp_select),
					["<C-n>"]   = cmp.mapping.select_next_item(cmp_select),
					["<C-y>"]   = cmp.mapping.confirm({ select = true }),
					["<Tab>"]   = cmp.mapping.confirm({ select = true }),
					["<C-m>"]   = cmp.mapping.complete(),
					["<C-e>"]   = cmp.mapping.close(),
					["<Esc>"]   = cmp.mapping.close(),
					["<CR>"]    = cmp.mapping.confirm({ select = true }),
					["<Right>"] = cmp.mapping.confirm({
						behavior = cmp.ConfirmBehavior.Replace,
						select = true,
					}),
				}),
			})
		end,
		enabled = vim.g.vscode == nil,
	},

	-- LSP keymaps + format-on-save via autocmds
	{
		"neovim/nvim-lspconfig",
		event = "BufReadPre",
		config = function()
			-- Keymaps on attach
			vim.api.nvim_create_autocmd("LspAttach", {
				callback = function(event)
					local opts = { buffer = event.buf, remap = false }

					vim.keymap.set("n", "gd",          vim.lsp.buf.definition,       opts)
					vim.keymap.set("n", "K",           vim.lsp.buf.hover,            opts)
					vim.keymap.set("n", "<leader>vws", vim.lsp.buf.workspace_symbol, opts)
					vim.keymap.set("n", "<leader>vd",  vim.diagnostic.open_float,    opts)
					vim.keymap.set("n", "[d",          vim.diagnostic.goto_next,     opts)
					vim.keymap.set("n", "]d",          vim.diagnostic.goto_prev,     opts)
					vim.keymap.set("n", "<leader>vca", vim.lsp.buf.code_action,      opts)
					vim.keymap.set("n", "<leader>vrr", vim.lsp.buf.references,       opts)
					vim.keymap.set("n", "<leader>vrn", vim.lsp.buf.rename,           opts)
					vim.keymap.set("i", "<C-h>",       vim.lsp.buf.signature_help,   opts)
					vim.keymap.set("n", "<leader>vh",  vim.lsp.buf.signature_help,   opts)
					vim.keymap.set("n", "<leader>f",   vim.lsp.buf.format,           opts)
				end,
			})

			-- Format on save (replaces lsp-zero's format_on_save)
			local fmt_servers = {
				pylsp         = { "python" },
				rust_analyzer = { "rust" },
				lua_ls        = { "lua" },
				clangd        = { "c", "cpp", "objc", "objcpp", "cuda", "proto" },
			}

			-- Build a reverse map: filetype -> server name
			local ft_to_server = {}
			for server, fts in pairs(fmt_servers) do
				for _, ft in ipairs(fts) do
					ft_to_server[ft] = server
				end
			end

			vim.api.nvim_create_autocmd("BufWritePre", {
				callback = function(event)
					local ft = vim.bo[event.buf].filetype
					local server = ft_to_server[ft]
					if server then
						vim.lsp.buf.format({
							async = false,
							timeout_ms = 10000,
							filter = function(client)
								return client.name == server
							end,
						})
					end
				end,
			})
		end,
		enabled = vim.g.vscode == nil,
	},
}
