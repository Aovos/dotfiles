-- ==========================================================================
-- SCRIPT MODULE: run_code
-- Zuständigkeit: Erkennt die Programmiersprache und führt sie im Terminal-Split aus
-- ==========================================================================

return function()
  -- Automatisches Speichern, falls die Datei modifiziert wurde
  if vim.bo.modified then 
    vim.cmd("write") 
  end

  -- Zuweisung der passenden Ausführbefehle für die jeweilige Sprache
  local ext_map = {
    java = "java " .. vim.fn.shellescape(vim.fn.expand("%:t")),
    cs   = "dotnet run",
    lua  = "lua " .. vim.fn.shellescape(vim.fn.expand("%:t")),
    sh   = "bash " .. vim.fn.shellescape(vim.fn.expand("%:t"))
  }

  local filetype = vim.bo.filetype

  -- Abbrechen, falls die Sprache nicht unterstützt wird
  if not ext_map[filetype] then
    print("Kein Runner für '" .. filetype .. "' definiert.")
    return
  end

  -- Befehl und Pfad vorbereiten
  local dir = vim.fn.shellescape(vim.fn.expand("%:p:h"))
  local cmd = "cd " .. dir .. " && " .. ext_map[filetype]

  -- 1. Neuen Split unten öffnen (Höhe 12)
  vim.cmd("botright 12split")
  
  -- 2. Scratch-Buffer erstellen (wird beim Schließen automatisch gelöscht)
  local buf = vim.api.nvim_create_buf(false, true)
  
  -- Buffer-Optionen für sauberes Terminal-Verhalten setzen
  vim.api.nvim_buf_set_option(buf, "bufhidden", "wipe")
  
  -- Buffer im neuen Fenster anzeigen
  vim.api.nvim_win_set_buf(0, buf)

  -- 3. Terminal starten
  vim.fn.termopen(cmd)
  
  -- 4. Sofort in den Terminal-Modus wechseln
  vim.cmd("startinsert")
end
