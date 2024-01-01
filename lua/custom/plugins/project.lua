return {
  'ahmedkhalf/project.nvim',
  config = function()
    require('project_nvim').setup {
      -- manual_mode = true,
      -- detection_methods = { 'pattern' },
      detection_methods = { 'pattern', 'lsp' },
      show_hidden = true,
    }
  end,
}
