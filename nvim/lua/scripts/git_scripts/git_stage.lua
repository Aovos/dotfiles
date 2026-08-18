-- ==========================================================================
-- SCRIPT MODULE: git_stage
-- Zuständigkeit: Alles stagen, Datei stagen oder Staging zurücksetzen
-- ==========================================================================

local M = {}

local function refresh_git(msg)
  vim.api.nvim_echo({{ "✓ " .. msg, "DiagnosticOk" }}, true, {})
  pcall(function() require("gitsigns").refresh() end)
end

function M.stage_all()
  vim.cmd("silent !git add .")
  refresh_git("Alles erfolgreich gestaged!")
end

function M.stage_current()
  vim.cmd("Gitsigns stage_buffer")
  refresh_git("Aktuelle Datei gestaged!")
end

function M.unstage_all()
  vim.cmd("silent !git reset")
  refresh_git("Staging komplett zurückgesetzt!")
end

return M

