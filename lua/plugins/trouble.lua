if not vim.g.vscode then
	return {
		{
			"folke/trouble.nvim",
			enable = vim.g.vscode == nil,
		},
	}
else
	return {}
end
