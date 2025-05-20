return {
  "yetone/avante.nvim",
  enabled = false,
  event = "VeryLazy",
  lazy = false,
  version = false, -- set this if you want to always pull the latest change
  opts = {
    provider = "gemini",
    gemini = {
      endpoint = "https://generativelanguage.googleapis.com/v1beta/models",
      model = "gemini-2.0-flash",
      timeout = 30000, -- Timeout in milliseconds
      temperature = 0,
      max_tokens = 8192,
    },
    -- provider = "deepseek",
    -- vendors = {
    --   deepseek = {
    --     __inherited_from = "openai",
    --     api_key_name = "OPENROUTER_API_KEY",
    --     endpoint = "https://openrouter.ai/api/v1",
    --     model = "deepseek/deepseek-r1-distill-llama-70b:free",
    --   },
    -- },
  },
  -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
  build = "make",
  -- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- for windows
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "stevearc/dressing.nvim",
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
    {
      -- support for image pasting
      "HakonHarnes/img-clip.nvim",
      event = "VeryLazy",
      opts = {
        -- recommended settings
        default = {
          embed_image_as_base64 = false,
          prompt_for_file_name = false,
          drag_and_drop = {
            insert_mode = true,
          },
          -- required for Windows users
          use_absolute_path = true,
        },
      },
    },
    {
      -- Make sure to set this up properly if you have lazy=true
      "MeanderingProgrammer/render-markdown.nvim",
      opts = {
        file_types = { "markdown", "Avante" },
      },
      ft = { "markdown", "Avante" },
    },
  },
}
