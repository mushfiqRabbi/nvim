return {
  "stevearc/oil.nvim",

  dependencies = { "nvim-tree/nvim-web-devicons" },

  config = function()
    local oil = require("oil")
    local util = require("oil.util")

    oil.setup({
      float = {
        border = "single",
      },
      preview = {
        border = "single",
      },
      progress = {
        border = "single",
      },
      keymaps = {
        ["<C-s>"] = false,
        ["<C-v>"] = "actions.select_vsplit",
        ["<CR>"] = {
          callback = function()
            if oil.get_cursor_entry().type == "directory" then
              oil.open(oil.get_current_dir() .. oil.get_cursor_entry().parsed_name)
            else
              oil.select()
            end
          end,
          mode = "n",
        },
        ["<C-g>"] = {
          callback = function()
            local preview = util.get_preview_win()
            if preview then
              vim.api.nvim_win_close(preview, true)
            end
            oil.close()
          end,
          mode = { "n", "v", "i" },
        },
        ["<C-\\>"] = {
          callback = function()
            if vim.api.nvim_get_mode().mode == "i" then
              vim.cmd("stopinsert")
            end
            local dir = oil.get_current_dir()
            local root_dir = vim.fn.FindRootDirectory(dir)
            if root_dir == "" then
              vim.cmd(string.format("ToggleTerm dir=%s", dir))
              -- if vim.api.nvim_get_mode().mode == "n" then
              vim.cmd.normal("i")
              -- end
            else
              vim.cmd(string.format("ToggleTerm dir=%s", root_dir))
              -- if vim.api.nvim_get_mode().mode == "n" then
              vim.cmd.normal("i")
              -- end
            end
          end,
          mode = { "n", "v", "i" },
        },
      },

      cleanup_delay_ms = 0,
      view_options = {
        show_hidden = true,
      },
      skip_confirm_for_simple_edits = true,
    })

    -- vim.keymap.set(
    --   { "n", "v", "i" },
    --   "<C-g>",
    --   "<cmd>Oil<CR>",
    --   { noremap = true, silent = true, desc = "[] Explore files/folders" }
    -- )

    vim.api.nvim_create_autocmd("User", {
      pattern = "OilEnter",
      callback = vim.schedule_wrap(function(args)
        if vim.api.nvim_get_current_buf() == args.data.buf and oil.get_cursor_entry() then
          oil.select({ preview = true })
        end
      end),
    })

    vim.api.nvim_create_autocmd({ "BufEnter", "BufLeave" }, {
      pattern = "oil:///*",
      callback = function(ev)
        if ev.event == "BufEnter" then
          vim.cmd(string.format("vertical resize %d", vim.o.columns * 0.3))
        elseif ev.event == "BufLeave" then
          if vim.api.nvim_win_get_config(0).relative == "" then
            vim.cmd(string.format("vertical resize %d", vim.o.columns * 0.2))
          else
            return
          end
        end
      end,
    })
  end,
}
