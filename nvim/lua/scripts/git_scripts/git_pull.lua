-- ==========================================================================
-- SCRIPT MODULE: git_pull
-- Zuständigkeit: Änderungen von GitHub holen & Fehler verständlich melden
-- ==========================================================================

return function()
  local output = vim.fn.system("git pull")
  local exit_code = vim.v.shell_error

  if exit_code == 0 then
    if output:match("Already up to date")
      or output:match("Bereits aktuell") then

      vim.api.nvim_echo({
        { "✓ Repository ist bereits aktuell.", "DiagnosticInfo" }
      }, true, {})

    else
      vim.api.nvim_echo({
        { "✓ Änderungen erfolgreich übernommen.", "DiagnosticOk" }
      }, true, {})
    end

  else
    local conflicts = vim.fn.systemlist(
      "git diff --name-only --diff-filter=U"
    )

    -- Merge-Konflikte
    if #conflicts > 0 then
      vim.notify(
        "Merge-Konflikt erkannt:\n\n" ..
        table.concat(conflicts, "\n"),
        vim.log.levels.WARN,
        { title = "Git" }
      )

    -- Authentifizierung
    elseif output:match("Authentication failed")
        or output:match("Invalid username or token")
        or output:match("could not read Username") then

      vim.notify(
        "GitHub-Anmeldung fehlgeschlagen. Bitte Token oder Zugangsdaten prüfen.",
        vim.log.levels.ERROR,
        { title = "Git" }
      )

    -- Netzwerk
    elseif output:match("Could not resolve host")
        or output:match("Failed to connect")
        or output:match("Connection timed out") then

      vim.notify(
        "Keine Verbindung zum Remote-Repository möglich.",
        vim.log.levels.ERROR,
        { title = "Git" }
      )

    -- Kein Remote
    elseif output:match("No remote repository specified")
        or output:match("does not appear to be a git repository") then

      vim.notify(
        "Kein gültiges Remote-Repository konfiguriert.",
        vim.log.levels.ERROR,
        { title = "Git" }
      )

    -- Kein Upstream
    elseif output:match("no tracking information")
        or output:match("has no upstream branch") then

      vim.notify(
        "Für diesen Branch ist kein Upstream konfiguriert.",
        vim.log.levels.WARN,
        { title = "Git" }
      )

    -- Lokale Änderungen würden überschrieben
    elseif output:match("would be overwritten by merge") then

      vim.notify(
        "Pull abgebrochen: Lokale Änderungen würden überschrieben.",
        vim.log.levels.WARN,
        { title = "Git" }
      )

    -- Unbekannter Fehler
    else
      vim.notify(
        string.format(
          "Git Pull fehlgeschlagen.\nFehlercode: %d",
          exit_code
        ),
        vim.log.levels.ERROR,
        { title = "Git" }
      )
    end
  end

  pcall(function()
    require("gitsigns").refresh()
  end)
end
