if not vim.g.vscode then
	return {
		{
			"nvim-treesitter/nvim-treesitter",
			build = ":TSUpdate",
			config = function()
				require("nvim-treesitter.configs").setup({
					-- A list of parser names, or "all"
					ensure_installed = { "vimdoc", "python", "c", "lua", "rust" },

					-- Install parsers synchronously (only applied to `ensure_installed`)
					sync_install = false,

					-- Automatically install missing parsers when entering buffer
					-- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
					auto_install = true,

					highlight = {
						-- `false` will disable the whole extension
						enable = true,
						disable = { "csv" },
					},
					indent = { enable = true },
				})
			end,
			enable = vim.g.vscode == nil,
		},
	}
else
    return {}
end
