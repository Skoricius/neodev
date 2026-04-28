return {
  "github/copilot.vim",
  event = "VeryLazy",
  config = function()
    -- Accept suggestion with Tab
    vim.keymap.set("i", "<Tab>", 'copilot#Accept("\\<Tab>")', {
      expr = true,
      replace_keycodes = false,
      desc = "Copilot: Accept suggestion",
    })

    -- Navigate suggestions
    vim.keymap.set("i", "<C-]>", "<Plug>(copilot-next)", { desc = "Copilot: Next suggestion" })
    vim.keymap.set("i", "<C-[>", "<Plug>(copilot-previous)", { desc = "Copilot: Previous suggestion" })

    -- Dismiss suggestion
    vim.keymap.set("i", "<C-e>", "<Plug>(copilot-dismiss)", { desc = "Copilot: Dismiss suggestion" })
  end,
}
