return {
	{
		"benlubas/molten-nvim",
		version = "^1.0.0",
		build = ":UpdateRemotePlugins",
		enabled = vim.g.vscode == nil,
		dependencies = {
			"3rd/image.nvim",
		},
		init = function()
			-- Use image.nvim for output images
			vim.g.molten_image_provider = "image.nvim"
			-- Show output below the cell, not in a floating window
			vim.g.molten_output_win_max_height = 20
			-- Auto-open output window when running a cell
			vim.g.molten_auto_open_output = true
			-- Wrap output text
			vim.g.molten_wrap_output = true
			-- Virt text for when outputs are hidden
			vim.g.molten_virt_text_output = true
			vim.g.molten_virt_lines_off_by_1 = true
			-- Don't enter output window automatically
			vim.g.molten_enter_output_behavior = "open_then_enter"
			-- Tick the kernel check rate
			vim.g.molten_tick_rate = 142
		end,
		config = function()
			-- Resolve the local venv python for the current project.
			-- Mirrors the same priority order used by pyright in lsp.lua:
			--   1. $VIRTUAL_ENV env var
			--   2. <cwd>/.venv/bin/python  (uv / plain venv)
			--   3. poetry env (async, best-effort)
			local function get_venv_python()
				if vim.env.VIRTUAL_ENV then
					return vim.env.VIRTUAL_ENV .. "/bin/python"
				end
				local cwd = vim.fn.getcwd()
				local uv_python = cwd .. "/.venv/bin/python"
				if vim.fn.executable(uv_python) == 1 then
					return uv_python
				end
				return nil
			end

			-- Derive a stable kernel name from the venv path so we only register once.
			local function kernel_name_for(python_path)
				-- use the parent dir name of the venv, e.g. "myproject" from
				-- /home/user/myproject/.venv/bin/python
				local venv_dir = python_path:match("^(.*)/bin/python$") or python_path
				local name = venv_dir:match("([^/]+)$") or "venv"
				return "venv-" .. name
			end

			-- Check whether a kernelspec with the given name is already registered.
			local function kernel_exists(name)
				local result = vim.fn.system({ "jupyter", "kernelspec", "list", "--json" })
				local ok, decoded = pcall(vim.json.decode, result)
				if ok and decoded and decoded.kernelspecs then
					return decoded.kernelspecs[name] ~= nil
				end
				return false
			end

			-- Register a new ipykernel for the given python path, then call MoltenInit.
			-- Falls back to the normal MoltenInit picker if anything goes wrong.
			local function molten_init_smart()
				local python = get_venv_python()

				if not python then
					-- No local venv found — check for poetry async
					local cwd = vim.fn.getcwd()
					if vim.fn.filereadable(cwd .. "/poetry.lock") == 1 then
						vim.notify("Molten: detecting poetry venv…", vim.log.levels.INFO)
						vim.system(
							{ "poetry", "env", "info", "--path" },
							{ cwd = cwd, text = true },
							function(result)
								vim.schedule(function()
									if result.code == 0 then
										local venv = result.stdout:gsub("%s+$", "")
										local py = venv .. "/bin/python"
										if vim.fn.executable(py) == 1 then
											molten_init_with_python(py)
										else
											vim.cmd("MoltenInit")
										end
									else
										vim.cmd("MoltenInit")
									end
								end)
							end
						)
					else
						-- No venv at all — show molten's normal picker
						vim.cmd("MoltenInit")
					end
					return
				end

				molten_init_with_python(python)
			end

			-- Do the actual kernel registration + MoltenInit for a resolved python path.
			function molten_init_with_python(python)
				local name = kernel_name_for(python)

				local function do_init()
					vim.notify('Molten: starting kernel "' .. name .. '"', vim.log.levels.INFO)
					vim.cmd("MoltenInit " .. name)
				end

				if kernel_exists(name) then
					do_init()
				else
					vim.notify('Molten: registering kernel "' .. name .. '"...', vim.log.levels.INFO)
					vim.system(
						{
							python, "-m", "ipykernel", "install",
							"--user",
							"--name", name,
							"--display-name", name,
						},
						{ text = true },
						function(result)
							vim.schedule(function()
								if result.code == 0 then
									do_init()
								else
									vim.notify(
										"Molten: kernel registration failed:\n" .. (result.stderr or ""),
										vim.log.levels.ERROR
									)
									vim.cmd("MoltenInit") -- fall back to picker
								end
							end)
						end
					)
				end
			end

			-- Keymaps
			local map = function(mode, lhs, rhs, desc)
				vim.keymap.set(mode, lhs, rhs, { desc = desc, silent = true })
			end

			-- Init / kernel management
			map("n", "<leader>mi", molten_init_smart,                    "Molten: init kernel (auto-venv)")
			map("n", "<leader>mK", ":MoltenInit<CR>",                    "Molten: init kernel (picker)")
			map("n", "<leader>mk", ":MoltenDeinit<CR>",                  "Molten: deinit kernel")

			-- Run cells
			map("n", "<leader>mr", ":MoltenEvaluateOperator<CR>",        "Molten: run operator (then motion)")
			map("n", "<leader>mc", ":MoltenReevaluateCell<CR>",          "Molten: re-run cell")
			map("n", "<leader>ml", ":MoltenEvaluateLine<CR>",            "Molten: run line")
			map("v", "<leader>mr", ":<C-u>MoltenEvaluateVisual<CR>gv",   "Molten: run visual")
			map("n", "<leader>ma", ":MoltenReevaluateAll<CR>",           "Molten: re-run all cells")

			-- Output management
			map("n", "<leader>mo", ":MoltenShowOutput<CR>",              "Molten: show output")
			map("n", "<leader>mh", ":MoltenHideOutput<CR>",              "Molten: hide output")
			map("n", "<leader>md", ":MoltenDelete<CR>",                  "Molten: delete cell output")
			map("n", "<leader>mw", ":MoltenEnterOutput<CR>",             "Molten: enter output window")

			-- Export back to .ipynb (requires jupytext)
			map("n", "<leader>me", function()
				local file = vim.fn.expand("%:p")
				local out = file:gsub("%.py$", ".ipynb")
				vim.fn.system({ "jupytext", "--to", "notebook", file, "--output", out })
				vim.notify("Exported to " .. out, vim.log.levels.INFO)
			end, "Molten: export to .ipynb")

			-- Import from .ipynb (convert to paired .py with jupytext, then open)
			map("n", "<leader>mI", function()
				local file = vim.fn.expand("%:p")
				if file:match("%.ipynb$") then
					vim.fn.system({ "jupytext", "--to", "py:percent", file })
					local py_file = file:gsub("%.ipynb$", ".py")
					vim.cmd("edit " .. py_file)
					vim.notify("Opened " .. py_file, vim.log.levels.INFO)
				else
					vim.notify("Not an .ipynb file", vim.log.levels.WARN)
				end
			end, "Molten: import from .ipynb")
		end,
	},

	-- Auto-convert .ipynb to .py on open and attach molten
	{
		"GCBallesteros/NotebookNavigator.nvim",
		enabled = vim.g.vscode == nil,
		dependencies = {
			"benlubas/molten-nvim",
			"echasnovski/mini.comment",
		},
		event = "VeryLazy",
		opts = {
			cell_markers = {
				python = "# %%",
			},
			-- Highlight the current cell
			activate_cell_highlight = true,
			-- Navigate between cells
			move_to_next_cell_linewise = false,
		},
		config = function(_, opts)
			local nn = require("notebook-navigator")
			nn.setup(opts)

			local map = function(mode, lhs, rhs, desc)
				vim.keymap.set(mode, lhs, rhs, { desc = desc, silent = true })
			end

			-- Cell navigation
			map("n", "]c", function() nn.move_cell("d") end, "Notebook: next cell")
			map("n", "[c", function() nn.move_cell("u") end, "Notebook: prev cell")

			-- Run current cell via molten (select cell lines, evaluate, stay)
			map("n", "<leader>mR", function()
				-- Select the cell content with inner-paragraph motion and evaluate
				vim.cmd("MoltenEvaluateOperator")
				vim.api.nvim_feedkeys("ip", "n", false)
			end, "Notebook: run cell")

			-- Run current cell and move to next
			map("n", "<leader>mn", function()
				vim.cmd("MoltenEvaluateOperator")
				vim.api.nvim_feedkeys("ip", "n", false)
				nn.move_cell("d")
			end, "Notebook: run cell and move to next")
		end,
	},
}
