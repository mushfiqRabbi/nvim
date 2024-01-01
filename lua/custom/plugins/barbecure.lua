return {
  "utilyre/barbecue.nvim",
  name = "barbecue",
  version = "*",
  dependencies = {
    {
      "catppuccin/nvim",
      name = "catppuccin",
    },
    "SmiteshP/nvim-navic",
    "nvim-tree/nvim-web-devicons", -- optional dependency
  },
  config = function()
    require("barbecue").setup({
      theme = "catppuccin-mocha", -- catppuccin-latte, catppuccin-frappe, catppuccin-macchiato, catppuccin-mocha
    })
  end,
}
