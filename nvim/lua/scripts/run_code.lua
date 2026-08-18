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

  -- Wenn die aktuelle Sprache unterstützt wird, öffne das Terminal
  if ext_map[vim.bo.filetype] then
    -- Öffnet einen kleinen Split unten (Höhe 12) und führt den Befehl im richtigen Ordner aus
    vim.cmd("botright split | resize 12 | terminal cd " .. vim.fn.shellescape(vim.fn.expand("%:p:h")) .. " && " .. ext_map[vim.bo.filetype])
    vim.cmd("startinsert") -- Springt sofort in den Terminal-Modus
  else
    print("Kein Runner für '" .. vim.bo.filetype .. "' definiert.")
  end
end

