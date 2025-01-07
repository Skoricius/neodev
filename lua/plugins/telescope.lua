if not vim.g.vscode then
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
						ignore_patterns = { "*.git/*", "*/tmp/*" },
						layout_config = {
							horizontal = { prompt_position = "top", preview_width = 0.55 },
							vertical = { mirror = false },
							width = 0.87,
							height = 0.80,
							preview_cutoff = 120,
						},
						path_display = filenameFirst,
						file_ignore_patterns = {
							"*.bak/",
							".git/",
							".vscode/",
						},
					},
					extensions = {
						frecency = {
							show_score = false,
							show_unindexed = true,
							-- ignore_patterns = { "*.git/*", "*/tmp/*" },
							disable_devicons = false,
							path_display = filenameFirst,
							recency_values = {
								{ age = 1, value = 500 }, -- past 20 mins
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
				-- require("telescope").load_extension "frecency"
			end,
			enable = vim.g.vscode == nil,
		},
	}
else
	return {}
end
