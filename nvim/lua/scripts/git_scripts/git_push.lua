-- ==========================================================================
-- SCRIPT MODULE: git_push
-- Zuständigkeit: Änderungen zu GitHub pushen & UI-Refresh
-- ==========================================================================

return function()
  vim.cmd("silent !git push")
  
  if vim.v.shell_error == 0 then
    vim.api.nvim_echo({{ "✓ GitHub Push erfolgreich!", "DiagnosticOk" }}, true, {})
    pcall(function() require("gitsigns").refresh() end)
  else
    vim.api.nvim_echo({{ "✗ Fehler beim Push zu GitHub!", "DiagnosticError" }}, true, {})
  end
end

