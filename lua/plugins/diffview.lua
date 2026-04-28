return {
  "sindrets/diffview.nvim",
  cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewToggleFiles", "DiffviewFocusFiles", "DiffviewFileHistory" },
  keys = {
    { "<leader>do", "<cmd>DiffviewOpen<cr>",  desc = "Diffview: Open" },
    { "<leader>dc", "<cmd>DiffviewClose<cr>", desc = "Diffview: Close" },
  },
}
