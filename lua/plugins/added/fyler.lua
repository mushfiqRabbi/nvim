--- Toggle fyler with smooth focus management
--- @param dir string The directory to open fyler with
--- @param old_win integer The window ID to return focus to
local toggle_fyler_with_focus = function(dir, old_win)
  -- Ensure clean state and open with smooth focus management
  local fyler = require("fyler")
  fyler.close()
  vim.defer_fn(function()
    fyler.open({ dir = dir })

    -- Switch back to original window immediately to prevent focus steal
    vim.defer_fn(function()
      vim.api.nvim_set_current_win(old_win)

      -- Then navigate to current file after a delay
      vim.defer_fn(function()
        local buf_name = vim.api.nvim_buf_get_name(0)
        if buf_name ~= "" then
          fyler.navigate(buf_name)
        end
      end, 200)
    end, 10) -- Very short delay to switch focus back quickly
  end, 50)
end

-- Cache the current working directory function to avoid repeated calls
local function get_cwd()
  return vim.uv.cwd() or vim.fn.getcwd()
end

local function get_project_root()
  -- Try to get the project root with better fallback logic
  local root = require("lazyvim.util").root()

  -- If LazyVim root detection returns empty or root of a subdirectory,
  -- we'll try to detect the actual project root
  if not root or root == "" then
    return get_cwd()
  end

  -- Additional check: if we're in a subproject that's inside a larger project,
  -- we might want the larger project's root
  local current_file = vim.api.nvim_buf_get_name(0)
  local current_dir
  if current_file and current_file ~= "" then
    current_dir = vim.fn.fnamemodify(current_file, ":h")
  else
    current_dir = get_cwd()
  end

  -- If the detected root is the current dir, use current working directory instead
  if root == current_dir then
    return get_cwd()
  end

  return root
end

-- Helper function to check if fyler is currently open
local function is_fyler_open()
  local finder = require("fyler.views.finder")
  return finder._current ~= nil
    and finder._current.win
    and finder._current.win:has_valid_winid()
end

-- Helper function to toggle fyler
local function toggle_fyler(dir)
  local old_win = vim.api.nvim_get_current_win()
  local fyler = require("fyler")
  if is_fyler_open() then
    fyler.close()
  else
    toggle_fyler_with_focus(dir, old_win)
  end
end

return {
  "A7Lavinraj/fyler.nvim",
  dependencies = { "nvim-mini/mini.icons" },
  branch = "stable", -- Use stable branch for production
  lazy = false,
  keys = {
    {
      "<leader>e",
      function()
        toggle_fyler(get_project_root())
      end,
      desc = "Toggle Fyler (root dir)",
    },
    {
      "<leader>E",
      function()
        toggle_fyler(get_cwd())
      end,
      desc = "Toggle Fyler (cwd)",
    },
  },

  opts = {
    views = {
      finder = {
        close_on_select = false,
        watcher = {
          enabled = true,
        },
        win = {
          kind = "split_left_most",
          kinds = {
            split_left_most = {
              width = "15%",
              win_opts = {
                winfixwidth = true,
              },
            },
          },
          win_opts = {
            cursorline = true,
          },
        },
      },
    },
  },
}
