-- ==========================================================================
-- SCRIPT MODULE: rename_target
-- Zuständigkeit: Datei oder Ordner interaktiv umbenennen (Absturz-Schutz)
-- ==========================================================================

local function get_target_path()
  if vim.bo.filetype == "neo-tree" then
    local node = require("neo-tree.sources.manager").get_state("filesystem").tree:get_node()
    return node and node.path or nil
  end
  local buf_name = vim.api.nvim_buf_get_name(0)
  return buf_name ~= "" and buf_name or nil
end

return function()
  local target = get_target_path()
  if not target then return end
  local old_name = vim.fn.fnamemodify(target, ":t")
  local new_name = vim.fn.input("Neuer Name für '" .. old_name .. "': ", old_name)
  if new_name == "" or new_name == old_name then return end

  local new_path = vim.fn.fnamemodify(target, ":h") .. "/" .. new_name
  
  if os.rename(target, new_path) then
    if vim.bo.filetype == "neo-tree" then 
      require("neo-tree.sources.manager").refresh("filesystem")
    else 
      -- ABSTURZ-SCHUTZ: Erst Ersatz-Tab aufmachen, dann alten Buffer killen, dann neue Datei laden
      local current_buf = vim.api.nvim_get_current_buf()
      vim.cmd("enew")
      vim.cmd("bd! " .. current_buf)
      vim.cmd("edit " .. vim.fn.fnameescape(new_path))
    end
    vim.api.nvim_echo({{ "✓ Erfolgreich umbenannt!", "DiagnosticOk" }}, true, {})
  else
    vim.api.nvim_echo({{ "✗ Fehler beim Umbenennen!", "DiagnosticError" }}, true, {})
  end
end
