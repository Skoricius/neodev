return {
	-- otter.nvim: LSP features inside embedded code blocks (notebook cells)
	{
		"jmbuhr/otter.nvim",
		enabled = vim.g.vscode == nil,
		dependencies = {
			"neovim/nvim-lspconfig",
			"nvim-treesitter/nvim-treesitter",
		},
		opts = {
			lsp = {
				-- Forward LSP hover / definition to the injected language server
				hover = {
					border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
				},
				diagnostic_update_events = { "BufWritePost", "InsertLeave", "TextChanged" },
			},
			buffers = {
				-- Write the injected code to a temp file so LSP can analyse it
				set_filetype = true,
				write_to_disk = false,
			},
			strip_wrapping_quote_characters = { "'", '"', "`" },
		},
	},

	-- quarto-nvim: first-class Quarto / Jupyter support using otter
	{
		"quarto-dev/quarto-nvim",
		enabled = vim.g.vscode == nil,
		ft = { "quarto", "markdown", "python" },
		dependencies = {
			"jmbuhr/otter.nvim",
			"nvim-treesitter/nvim-treesitter",
			"benlubas/molten-nvim",
		},
		opts = {
			lspFeatures = {
				-- Activate otter (embedded LSP) for these languages inside cells
				languages = { "python", "r", "bash" },
				chunks = "all",
				diagnostics = {
					enabled = true,
					triggers = { "BufWritePost" },
				},
				completion = {
					enabled = true,
				},
			},
			codeRunner = {
				enabled = true,
				default_method = "molten",
			},
		},
		config = function(_, opts)
			local quarto = require("quarto")
			quarto.setup(opts)

			local map = function(mode, lhs, rhs, desc)
				vim.keymap.set(mode, lhs, rhs, { desc = desc, silent = true })
			end

			-- Activate otter LSP for current buffer (useful for plain .py notebooks)
			map("n", "<leader>qa", function()
				require("otter").activate({ "python" }, true, true, nil)
			end, "Quarto/Otter: activate LSP")

			-- Run cell / selection via quarto (delegates to molten)
			map("n", "<leader>qr", quarto.quartoSend,                   "Quarto: run cell")
			map("v", "<leader>qr", quarto.quartoSendRange,              "Quarto: run range")
			map("n", "<leader>qa", quarto.quartoSendAbove,              "Quarto: run above")
			map("n", "<leader>qb", quarto.quartoSendBelow,              "Quarto: run below")
			map("n", "<leader>qA", quarto.quartoSendAll,                "Quarto: run all")

			-- Preview (requires quarto CLI, optional)
			map("n", "<leader>qp", quarto.quartoPreview,               "Quarto: preview")
			map("n", "<leader>qq", quarto.quartoClosePreview,          "Quarto: close preview")
		end,
	},
}
