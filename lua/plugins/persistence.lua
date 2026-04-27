return {
  "folke/persistence.nvim",
  lazy = false,
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

    -- Auto-restore on startup when no file args, or only a directory arg
    local function should_restore()
      if vim.fn.argc() == 0 then return true end
      if vim.fn.argc() == 1 then
        local arg = vim.fn.argv(0)
        return vim.fn.isdirectory(arg) == 1
      end
      return false
    end

    if should_restore() then
      vim.api.nvim_create_autocmd("VimEnter", {
        callback = function()
          vim.schedule(function()
            -- Wipe any neo-tree or directory buffers before restoring
            for _, buf in ipairs(vim.api.nvim_list_bufs()) do
              local ft = vim.bo[buf].filetype
              local bt = vim.bo[buf].buftype
              local name = vim.api.nvim_buf_get_name(buf)
              if ft == "neo-tree" or bt == "nofile" or vim.fn.isdirectory(name) == 1 then
                vim.api.nvim_buf_delete(buf, { force = true })
              end
            end
            local dir = get_session_dir()
            require("persistence").load({ dir = dir })
          end)
        end,
        nested = true,
      })
    end

    local function cleanup_and_save()
      for _, buf in ipairs(vim.api.nvim_list_bufs()) do
        local bt = vim.bo[buf].buftype
        local ft = vim.bo[buf].filetype
        if bt == "terminal" or ft == "neo-tree" then
          vim.api.nvim_buf_delete(buf, { force = true })
        end
      end
      require("persistence").save()
    end

    local function save_and_quit()
      cleanup_and_save()
      vim.cmd("qa!")
    end

    -- Save session on clean exit
    vim.api.nvim_create_autocmd("VimLeavePre", {
      callback = cleanup_and_save,
    })

    -- Save session on SIGTERM / SIGHUP (e.g. terminal ctrl-q, window close)
    local uv = vim.uv or vim.loop
    for _, sig in ipairs({ "sigterm", "sighup" }) do
      local handle = uv.new_signal()
      uv.signal_start(handle, sig, function()
        vim.schedule(save_and_quit)
      end)
    end
  end,
}
