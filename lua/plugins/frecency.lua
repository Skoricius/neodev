if not vim.g.vscode then
	return {
		{
			"nvim-telescope/telescope-frecency.nvim",
			enable = vim.g.vscode == nil,
		},
	}
else
	return {}
end
