return {
	{
		"theprimeagen/harpoon",
		dependencies = { "nvim-lua/plenary.nvim" },
		keys = {
			{ "<leader>a", desc = "Harpoon: add file" },
			{ "<leader>q", desc = "Harpoon: toggle menu" },
			{ "<leader>.", desc = "Harpoon: next" },
			{ "<leader>,", desc = "Harpoon: prev" },
		},
		config = function()
			local mark = require("harpoon.mark")
			local ui = require("harpoon.ui")

			vim.keymap.set("n", "<leader>a", mark.add_file)
			vim.keymap.set("n", "<leader>q", ui.toggle_quick_menu)
			vim.keymap.set("n", "<leader>.", ui.nav_next)
			vim.keymap.set("n", "<leader>,", ui.nav_prev)
		end,
		enabled = vim.g.vscode == nil,
	},
}
