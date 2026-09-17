-- ==========================================================================
-- MODULE: git_force_pull
-- Erzwingt den Remote-Stand und überschreibt lokale Änderungen komplett
-- ==========================================================================

return function()
  local function notify(msg, level, opts)
    vim.notify(
      msg,
      level,
      vim.tbl_extend('force', { title = 'Git Force Pull' }, opts or {})
    )
  end

  local function run(cmd)
    local output = vim.fn.system(cmd)
    local exit_code = vim.v.shell_error
    return vim.trim(output), exit_code
  end

  -- Sicherheitsabfrage via Neovim UI, damit man es nicht aus Versehen triggert
  vim.ui.input({
    prompt = "Möchtest du wirklich alle lokalen Änderungen verwerfen und den Remote-Stand erzwingen? (ja/nein): "
  }, function(input)
    if input ~= "ja" then
      print(" Force Pull abgebrochen.")
      return
    end

    print("Hole Remote-Daten...")
    local fetch_out, fetch_code = run('git fetch 2>&1')
    if fetch_code ~= 0 then
      notify("Git Fetch fehlgeschlagen:\n" .. fetch_out, vim.log.levels.ERROR)
      return
    end

    print("Setze Repository hart zurück...")
    -- @{u} steht dynamisch für den aktuell konfigurierten Upstream-Branch
    local reset_out, reset_code = run('git reset --hard @{u} 2>&1')

    if reset_code == 0 then
      vim.api.nvim_echo({
        { '✓ Repository erfolgreich auf Remote-Stand gesetzt.', 'DiagnosticOk' },
      }, true, {})
      
      -- Gitsigns aktualisieren
      pcall(function() require('gitsigns').refresh() end)
    else
      -- Fehlerbehandlung falls kein Upstream existiert
      if reset_out:match("no upstream configured") or reset_out:match("does not have an upstream") then
        notify("Fehler: Für diesen Branch ist kein Upstream-Branch konfiguriert.", vim.log.levels.ERROR)
      else
        notify("Git Reset fehlgeschlagen:\n" .. reset_out, vim.log.levels.ERROR)
      end
    end
  end)
end
