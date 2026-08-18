-- ==========================================================================
-- SCRIPT MODULE: smart_save
-- Zuständigkeit: Datei normal speichern, "Speichern unter" oder Autoname bei neuen Buffern
-- ==========================================================================

return function(action)
  -- Wenn action == "as" ist, fragen wir direkt nach einem neuen Pfad/Namen
  if action == "as" then
    vim.ui.input({
      prompt = "Speichern unter (Pfad/Dateiname): ",
      completion = "file" -- Aktiviert die Tab-Vervollständigung für Pfade und Dateien
    }, function(input)
      if input and input ~= "" then
        vim.cmd("write " .. input)
      else
        print("Abgebrochen.")
      end
    end)
  -- Wenn die Datei noch keinen Namen hat, fragen wir wie gewohnt nach einem Namen
  elseif vim.api.nvim_buf_get_name(0) == "" then
    vim.ui.input({
      prompt = "Dateiname mit Endung: ",
      completion = "file" -- Aktiviert die Tab-Vervollständigung auch hier, falls du Pfade tippst
    }, function(input)
      if input and input ~= "" then
        vim.cmd("write " .. input .. (action == "quit" and " | quit" or ""))
      else
        print("Abgebrochen.")
      end
    end)
  -- Standard-Verhalten für bereits benannte Dateien
  else
    vim.cmd(action == "quit" and "wq" or "write")
  end
end

