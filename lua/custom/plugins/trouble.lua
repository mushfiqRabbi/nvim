return {
  "folke/trouble.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  opts = {
    height = 20,
  },
  config = function()
    vim.keymap.set("n", "<leader>dd", function()
      require("trouble").toggle("document_diagnostics")
    end, { desc = "[D]iagnostic [D]ocument" })
    vim.keymap.set("n", "<leader>dw", function()
      require("trouble").toggle("workspace_diagnostics")
    end, { desc = "[D]iagnostic [W]orkspace" })
    vim.api.nvim_create_autocmd({ "BufEnter", "BufLeave" }, {
      pattern = "*/Trouble",
      callback = function(ev)
        if ev.event == "BufEnter" then
          vim.cmd(string.format("resize %d", vim.o.lines * 0.4))
        elseif ev.event == "BufLeave" then
          if vim.api.nvim_win_get_config(0).relative == "" then
            vim.cmd(string.format("resize %d", vim.o.lines * 0.2))
          else
            return
          end
        end
      end,
    })
  end,
}
