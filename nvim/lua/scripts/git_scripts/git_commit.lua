-- ==========================================================================
-- SCRIPT MODULE: git_commit
-- Zuständigkeit: Commit mit interaktiver Nachricht erstellen & UI-Refresh
-- ==========================================================================

return function()
  local msg = vim.fn.input('Commit Message: ')
  if msg == "" then 
    return vim.api.nvim_echo({{ "  Commit abgebrochen.", "Comment" }}, true, {}) 
  end

  vim.cmd('silent !git commit -m "' .. msg .. '"')
  
  if vim.v.shell_error == 0 then
    vim.api.nvim_echo({{ "✓ Commit erstellt: " .. msg, "DiagnosticOk" }}, true, {})
    pcall(function() require("gitsigns").refresh() end)
  else
    vim.api.nvim_echo({{ "✗ Fehler beim Erstellen des Commits!", "DiagnosticError" }}, true, {})
  end
end
