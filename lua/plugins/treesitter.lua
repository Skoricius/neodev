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
		end,
	},
}
