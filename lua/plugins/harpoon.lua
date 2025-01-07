if not vim.g.vscode then
	return {
		{
			"theprimeagen/harpoon",
			config = function()
				local mark = require("harpoon.mark")
				local ui = require("harpoon.ui")

				vim.keymap.set("n", "<leader>a", mark.add_file)
				vim.keymap.set("n", "<C-e>", ui.toggle_quick_menu)
				vim.keymap.set("n", "<leader>e", "<cmd>Neotree toggle<cr>")
			end,
			enable = vim.g.vscode == nil,
		},
	}
else
	return {}
end
