return {
    "nvim-neotest/neotest",
    dependencies= {
        "nvim-neotest/nvim-nio",
        "nvim-lua/plenary.nvim",
        "antoinemadec/FixCursorHold.nvim",
        "nvim-treesitter/nvim-treesitter",
        "nvim-neotest/neotest-python",
    },
    config = function()

        require("neotest").setup({
            adapters = {
                require("neotest-python")({
                    dap = { justMyCode = true },
                    args = { "-s", "--log-level", "DEBUG" },
                    runner = "pytest",
                })
            },
            discovery = {
                concurrent = 1,
                enabled = true,
            },
            -- floating = {
            --     border = "rounded",
            --     max_height = 0.9,
            --     max_width = 0.8,
            --     options = {}
            -- },
            icons = {
                passed = "",
                running = "",
                failed = "",
                unknown = "",
            },
            quickfix = { open = false },
            output = { open_on_run = false },
            lazy = true,
        })
        vim.keymap.set("n", "<leader>yr", require("neotest").run.run)
        vim.keymap.set("n", "<leader>yf",
            function() require("neotest").run.run(vim.fn.expand("%")) end
        )
        vim.keymap.set("n", "<leader>yt", require("neotest").run.stop)
        vim.keymap.set("n", "<leader>yd",
            function() require("neotest").run.run({ strategy = "dap" }) end
        )
        vim.keymap.set("n", "<leader>yp", require("neotest").output_panel.toggle)
        vim.keymap.set("n", "<leader>ys", require("neotest").summary.toggle)
        vim.keymap.set("n", "<leader>yo",
            function() require("neotest").output.open({ enter = true }) end
        )
        vim.keymap.set("n", "<leader>ya", require("neotest").run.attach)
    end,
    enable=vim.g.vscode == nil
};
