-- ==========================================================================
-- SCRIPT MODULE: git_pull
-- Zuständigkeit: Änderungen von GitHub holen & Fehler verständlich melden
-- ==========================================================================

return function()
  local output = vim.fn.system("git pull 2>&1")
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

    if #conflicts > 0 then
      vim.notify(
        "Merge-Konflikt erkannt:\n\n" ..
        table.concat(conflicts, "\n"),
        vim.log.levels.WARN,
        {
          title = "Git",
          timeout = 10000,
        }
      )

    elseif output:match("Need to specify how to reconcile divergent branches") then
      vim.notify(
        "Git Pull-Strategie nicht konfiguriert.\n\n" ..
        "Einmalig ausführen:\n" ..
        "git config --global pull.rebase false",
        vim.log.levels.WARN,
        { title = "Git" }
      )

    elseif output:match("Authentication failed")
        or output:match("Invalid username or token")
        or output:match("could not read Username") then

      vim.notify(
        "GitHub-Anmeldung fehlgeschlagen.\n" ..
        "Bitte Token oder Zugangsdaten prüfen.",
        vim.log.levels.ERROR,
        { title = "Git" }
      )

    elseif output:match("Could not resolve host")
        or output:match("Failed to connect")
        or output:match("Connection timed out") then

      vim.notify(
        "Keine Verbindung zum Remote-Repository möglich.",
        vim.log.levels.ERROR,
        { title = "Git" }
      )

    elseif output:match("No remote repository specified")
        or output:match("does not appear to be a git repository") then

      vim.notify(
        "Kein gültiges Remote-Repository konfiguriert.",
        vim.log.levels.ERROR,
        { title = "Git" }
      )

    elseif output:match("no tracking information")
        or output:match("has no upstream branch") then

      vim.notify(
        "Für diesen Branch ist kein Upstream konfiguriert.",
        vim.log.levels.WARN,
        { title = "Git" }
      )

    elseif output:match("would be overwritten by merge") then

      vim.notify(
        "Pull abgebrochen:\n" ..
        "Lokale Änderungen würden überschrieben.",
        vim.log.levels.WARN,
        { title = "Git" }
      )

    else
      vim.notify(
        "Git Pull fehlgeschlagen:\n\n" ..
        vim.trim(output),
        vim.log.levels.ERROR,
        {
          title = "Git",
          timeout = 15000,
        }
      )
    end
  end

  pcall(function()
    require("gitsigns").refresh()
  end)
end
