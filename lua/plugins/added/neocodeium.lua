return {
  "monkoose/neocodeium",
  event = "VeryLazy",
  config = function()
    local neocodeium = require("neocodeium")
    neocodeium.setup({
      silent = true,
      filetypes = {
        TelescopePrompt = false,
      },

      root_dir = { ".bzr", ".git", ".hg", ".svn", "_FOSSIL_", "package.json", ".root" },
    })
    vim.keymap.set("i", "<C-g>", function()
      require("neocodeium").accept()
    end)
    vim.keymap.set("i", "<C-w>", function()
      require("neocodeium").accept_word()
    end)
    vim.keymap.set("i", "<C-a>", function()
      require("neocodeium").accept_line()
    end)
    vim.keymap.set("i", "<C-e>", function()
      require("neocodeium").cycle_or_complete()
    end)
    vim.keymap.set("i", "<C-r>", function()
      require("neocodeium").cycle_or_complete(-1)
    end)
    vim.keymap.set("i", "<C-c>", function()
      require("neocodeium").clear()
    end)
    vim.keymap.set({ "n", "v" }, "<leader>ch", "<cmd>NeoCodeium chat<cr>", { desc = "NeoCodeium Chat" })
  end,
}
