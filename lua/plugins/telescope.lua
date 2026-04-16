return {
	{
		"nvim-telescope/telescope.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			local builtin = require("telescope.builtin")
			vim.keymap.set("n", "<leader>ff", builtin.git_files, {})
			vim.keymap.set("n", "<leader>fa", function()
				builtin.find_files({ no_ignore = true, no_ignore_parent = true })
			end, {})
			vim.keymap.set("n", "<C-f>", builtin.current_buffer_fuzzy_find, {})
			vim.keymap.set("n", "<leader>ls", require("telescope.builtin").lsp_document_symbols, {})
			vim.keymap.set("n", "<C-p>", "<Cmd>Telescope frecency workspace=CWD<CR> ", {})
			vim.keymap.set("n", "<leader>fs", builtin.live_grep, {})
			-- vim.keymap.set('n', '<leader>fs', function()
			--     builtin.grep_string({ search = vim.fn.input("Grep > ") })
			-- end)
			vim.keymap.set("n", "<leader>vh", builtin.help_tags, {})
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
				if parent == "." then
					return tail
				end
				return string.format("%s\t\t%s", tail, parent)
			end

			require("telescope").setup({
				defaults = {
					-- git_worktrees = vim.g.git_worktrees,
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
					file_ignore_patterns = {
						"%.bak/",
						"%.git/",
						"%.vscode/",
						"%.venv/",
						"venv/",
						"env/",
						"__pycache__/",
						"%.pyc$",
						"%.mypy_cache/",
						"%.pytest_cache/",
						"%.ruff_cache/",
						"dist/",
						"build/",
						"%.egg%-info/",
						"node_modules/",
					},
					vimgrep_arguments = {
						"rg",
						"--color=never",
						"--no-heading",
						"--with-filename",
						"--line-number",
						"--column",
						"--smart-case",
						"--glob=!.venv/**",
						"--glob=!venv/**",
						"--glob=!__pycache__/**",
						"--glob=!.git/**",
						"--glob=!node_modules/**",
					},
					preview = {
						treesitter = false,
					},
				},
				extensions = {
					frecency = {
						auto_validate = false,
						db_safe_mode = false,
						show_score = false,
						show_unindexed = true,
						disable_devicons = false,
						path_display = filenameFirst,
						workspace_scan_cmd = {
							"fd",
							"--type", "f",
							"--hidden",
							"--exclude", ".git",
							"--exclude", ".venv",
							"--exclude", "venv",
							"--exclude", "env",
							"--exclude", "__pycache__",
							"--exclude", ".mypy_cache",
							"--exclude", ".pytest_cache",
							"--exclude", ".ruff_cache",
							"--exclude", "node_modules",
							"--exclude", "dist",
							"--exclude", "build",
						},
						recency_values = {
							{ age = 1, value = 500 }, -- past 1 min
							{ age = 20, value = 300 }, -- past 20 mins
							{ age = 240, value = 100 }, -- past 4 hours
							{ age = 1440, value = 80 }, -- past day
							{ age = 4320, value = 60 }, -- past 3 days
							{ age = 10080, value = 40 }, -- past week
							{ age = 43200, value = 20 }, -- past month
							{ age = 129600, value = 10 }, -- past 90 days
						},
					},
				},
				pickers = {
					find_files = {
						path_display = filenameFirst,
					},
					git_files = {
						path_display = filenameFirst,
					},
					frecency = {
						path_display = filenameFirst,
					},
				},
			})
			require("telescope").load_extension("frecency")
		end,
		enabled = vim.g.vscode == nil,
	},
}
