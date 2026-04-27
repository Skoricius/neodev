return {
	-- Mason: installs LSP servers
	{
		"williamboman/mason.nvim",
		lazy = false,
		config = function()
			require("mason").setup({})
		end,
		enabled = vim.g.vscode == nil,
	},

	-- mason-lspconfig: bridges mason with Neovim's built-in LSP
	{
		"williamboman/mason-lspconfig.nvim",
		lazy = false,
		dependencies = {
			"neovim/nvim-lspconfig",
			"williamboman/mason.nvim",
			"hrsh7th/cmp-nvim-lsp",
		},
		config = function()
			local capabilities = require("cmp_nvim_lsp").default_capabilities()
			local lspconfig = require("lspconfig")

			-- pyright: resolve python interpreter from project venv (uv/poetry/plain venv)
			local function get_python_path(workspace)
				if vim.env.VIRTUAL_ENV then
					return vim.env.VIRTUAL_ENV .. "/bin/python"
				end
				local uv_python = workspace .. "/.venv/bin/python"
				if vim.fn.executable(uv_python) == 1 then
					return uv_python
				end
				return nil
			end

			require("mason-lspconfig").setup({
				ensure_installed = { "lua_ls", "rust_analyzer", "pyright" },
				handlers = {
					-- default handler: just add capabilities
					function(server_name)
						lspconfig[server_name].setup({ capabilities = capabilities })
					end,
					-- pyright: also resolve python path
					pyright = function()
						lspconfig.pyright.setup({
							capabilities = capabilities,
							on_init = function(client)
								local workspace = client.config.root_dir or vim.fn.getcwd()
								local python_path = get_python_path(workspace)
								if python_path then
									client.config.settings = vim.tbl_deep_extend("force",
										client.config.settings or {},
										{ python = { pythonPath = python_path } }
									)
									client.notify("workspace/didChangeConfiguration",
										{ settings = client.config.settings })
									return
								end
								if vim.fn.filereadable(workspace .. "/poetry.lock") == 1 then
									vim.system(
										{ "poetry", "env", "info", "--path" },
										{ cwd = workspace, text = true },
										function(result)
											if result.code == 0 then
												local venv = result.stdout:gsub("%s+$", "")
												local path = venv .. "/bin/python"
												vim.schedule(function()
													client.config.settings = vim.tbl_deep_extend("force",
														client.config.settings or {},
														{ python = { pythonPath = path } }
													)
													client.notify("workspace/didChangeConfiguration",
														{ settings = client.config.settings })
												end)
											end
										end
									)
								end
							end,
							settings = {
								python = {
									analysis = {
										autoImportCompletions = true,
										typeCheckingMode      = "basic",
									},
								},
							},
						})
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
