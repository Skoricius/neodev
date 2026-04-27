return {
  "folke/persistence.nvim",
  event = "BufReadPre",
  opts = {
    dir = vim.fn.expand(vim.fn.stdpath("state") .. "/sessions/"),
    need = 1,
  },
  init = function()
    local function get_session_dir()
      local git_root = vim.fn.systemlist("git rev-parse --show-toplevel")[1]
      if vim.v.shell_error == 0 and git_root and git_root ~= "" then
        return git_root
      end
      return vim.fn.getcwd()
    end

    -- Auto-restore on startup when no file args given
    if vim.fn.argc() == 0 then
      vim.api.nvim_create_autocmd("VimEnter", {
        callback = function()
          local dir = get_session_dir()
          require("persistence").load({ dir = dir })
        end,
        nested = true,
      })
    end

    -- Save session on exit, excluding terminal buffers
    vim.api.nvim_create_autocmd("VimLeavePre", {
      callback = function()
        for _, buf in ipairs(vim.api.nvim_list_bufs()) do
          if vim.bo[buf].buftype == "terminal" then
            vim.api.nvim_buf_delete(buf, { force = true })
          end
        end
        require("persistence").save()
      end,
    })
  end,
}
