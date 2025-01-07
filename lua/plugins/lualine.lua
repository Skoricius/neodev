if not vim.g.vscode then
	return {
		{
			"nvim-lualine/lualine.nvim",
			dependencies = { "nvim-tree/nvim-web-devicons" },
			enable = vim.g.vscode == nil,
		},
	}
else
	return {}
end
