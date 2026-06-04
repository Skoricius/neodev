return {
	{
		"nvim-treesitter/nvim-treesitter",
		branch = "main",
		lazy = false,
		build = ":TSUpdate",
		enabled = vim.g.vscode == nil,
		config = function()
			require("nvim-treesitter").setup({
				install_dir = vim.fn.stdpath("data") .. "/site",
			})
			-- Install parsers (no-op if already installed)
			if vim.fn.executable("tree-sitter") == 1 then
				require("nvim-treesitter").install({
					"vimdoc",
					"python",
					"c",
					"lua",
					"rust",
					"markdown",
					"markdown_inline",
					"json",
				})
			else
				vim.notify(
					"nvim-treesitter: tree-sitter CLI not found, parsers will not be auto-installed.\n"
						.. "Install it with: cargo install tree-sitter-cli",
					vim.log.levels.WARN
				)
			end
		end,
	},
}
