return {
  "lucaSartore/fastspell.nvim",
  enabled = false,
  -- automatically run the installation script on windows and linux)
  -- if this doesn't work for some reason, you can
  build = function()
    local base_path = vim.fn.stdpath("data") .. "/lazy/fastspell.nvim"
    local cmd = base_path .. "/lua/scripts/install." .. (vim.fn.has("win32") and "cmd" or "sh")
    vim.system({ cmd })
  end,

  config = function()
    local fastspell = require("fastspell")

    -- call setup to initialize fastspell
    fastspell.setup({
      -- Optionally put your custom configurations here
    })

    -- decide when to run the spell checking (see :help events for full list)
    vim.api.nvim_create_autocmd({ "TextChanged", "TextChangedI", "BufEnter", "WinScrolled" }, {
      callback = function(ctx)
        -- decide the area in your buffer that will be checked. This is the default configuration,
        -- and look for spelling mistakes ONLY in the lines of the bugger that are currently displayed
        -- for more advanced configurations see the section bellow
        local dir = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(ctx.buf), ":h")

        if vim.fs.find({ ".nocspell" }, { path = dir, type = "file", upward = true })[1] then
          fastspell.sendSpellCheckRequest(0, 0)
          return
        end

        local first_line = vim.fn.line("w0") - 1
        local last_line = vim.fn.line("w$")
        fastspell.sendSpellCheckRequest(first_line, last_line)
      end,
    })
  end,
}
