return {
	{
		"nvimdev/guard.nvim",
		dependencies = {
			"nvimdev/guard-collection",
		},
		config = function()
			local function has_value(tab, val)
				for index, value in ipairs(tab) do
					if value == val then
						return true
					end
				end

				return false
			end
			local ft = require("guard.filetype")

			local cwd = vim.fn.getcwd(-1, -1)
			local project_folder = cwd:match("/.*/(.*)")
			no_black_projects = { "qecf", "lcd-models" }
			if has_value(no_black_projects, project_folder) then
				ft("python"):fmt("autopep8"):append("isort")
			else
				ft("python"):fmt("black"):append("isort")
			end
			-- :lint('pylint')
			ft("typescript,javascript,typescriptreact,solidity"):fmt("prettier")
			ft("lua"):fmt("lsp"):append("stylua")

			-- Call setup() LAST!
			require("guard").setup({
				-- Choose to format on every write to a buffer
				fmt_on_save = true,
				-- Use lsp if no formatter was defined for this filetype
				lsp_as_default_formatter = false,
				-- By default, Guard writes the buffer on every format
				-- You can disable this by setting:
				-- save_on_fmt = false,
			})
		end,
		enable = vim.g.vscode == nil,
	},
}
