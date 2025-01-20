return {
  "ahmedkhalf/project.nvim",
  enabled = false,
  opts = {
    manual_mode = false,
    detection_methods = { "pattern" },
    patterns = { ".git", "_darcs", ".hg", ".bzr", ".svn", "Makefile", "package.json", ".root" },
  },
}
