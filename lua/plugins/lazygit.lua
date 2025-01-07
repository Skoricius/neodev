if not vim.g.vscode then
	return {
		{
			"kdheepak/lazygit.nvim",
			dependencies = {
				"nvim-lua/plenary.nvim",
			},
			config = function()
				require("Comment").setup({
					---Add a space b/w comment and the line
					padding = true,
					---Whether the cursor should stay at its position
					sticky = true,
				})
				vim.keymap.set("n", "<leader>/", function()
					require("Comment.api").toggle.linewise.count(vim.v.count > 0 and vim.v.count or 1)
				end)
				vim.keymap.set(
					"v",
					"<leader>/",
					"<esc><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<cr>"
				)
				vim.keymap.set("i", "<C-/>", function()
					require("Comment.api").toggle.linewise.count(vim.v.count > 0 and vim.v.count or 1)
				end)
				vim.keymap.set("n", "<leader>gg", vim.cmd.LazyGit)
			end,
			enable = vim.g.vscode == nil,
		},
	}
else
	return {}
end
