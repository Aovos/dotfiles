-- MODULE: git_pust
-- Robuster Git-Pull für Neovim
--
-- Features:
--   - git pull --no-rebase
--   - zuverlässige Merge-Konflikterkennung
--   - automatische Anzeige der ersten Konfliktdatei
--   - verständliche Fehlermeldungen
--   - Erkennung von Auth-, Netzwerk-, Upstream- und lokalen Änderungen
--   - Gitsigns-Refresh nach dem Pull
-- ==========================================================================

return function()
  ---------------------------------------------------------------------------
  -- Helpers
  ---------------------------------------------------------------------------

  local function notify(msg, level, opts)
    vim.notify(
      msg,
      level,
      vim.tbl_extend('force', {
        title = 'Git',
      }, opts or {})
    )
  end

  local function run(cmd)
    local output = vim.fn.system(cmd)
    local exit_code = vim.v.shell_error

    return vim.trim(output), exit_code
  end

  local function get_conflicts()
    local output = vim.fn.systemlist(
      'git diff --name-only --diff-filter=U 2>/dev/null'
    )

    return output or {}
  end

  local function refresh_gitsigns()
    pcall(function()
      require('gitsigns').refresh()
    end)
  end

  local function open_first_conflict(conflicts)
    if #conflicts == 0 then
      return
    end

    local file = conflicts[1]

    vim.schedule(function()
      -- Prüfen, ob die Datei noch existiert bzw. geöffnet werden kann.
      local ok, err = pcall(function()
        vim.cmd('edit ' .. vim.fn.fnameescape(file))
      end)

      if not ok then
        notify(
          'Konfliktdatei konnte nicht geöffnet werden:\n' .. tostring(err),
          vim.log.levels.ERROR
        )
      end
    end)
  end

  ---------------------------------------------------------------------------
  -- Git Pull
  ---------------------------------------------------------------------------

  local output, exit_code = run('git pull --no-rebase 2>&1')

  ---------------------------------------------------------------------------
  -- Erfolgreich
  ---------------------------------------------------------------------------

  if exit_code == 0 then
    if output == ''
      or output:match('Already up to date')
      or output:match('Bereits aktuell')
    then
      vim.api.nvim_echo({
        { '✓ Repository ist bereits aktuell.', 'DiagnosticInfo' },
      }, true, {})
    else
      vim.api.nvim_echo({
        { '✓ Änderungen erfolgreich übernommen.', 'DiagnosticOk' },
      }, true, {})
    end

    refresh_gitsigns()
    return
  end

  ---------------------------------------------------------------------------
  -- Pull fehlgeschlagen
  ---------------------------------------------------------------------------

  -- Konflikte IMMER zuerst prüfen.
  -- Das ist zuverlässiger als nach "CONFLICT" im Git-Output zu suchen.
  local conflicts = get_conflicts()

  if #conflicts > 0 then
    local conflict_message =
      'Merge-Konflikt erkannt.\n\n'
      .. table.concat(conflicts, '\n')

    notify(
      conflict_message,
      vim.log.levels.WARN,
      { timeout = 15000 }
    )

    open_first_conflict(conflicts)
    refresh_gitsigns()

    return
  end

  ---------------------------------------------------------------------------
  -- Pull-Strategie / divergierende Branches
  ---------------------------------------------------------------------------

  if output:match('Need to specify how to reconcile divergent branches')
    or output:match('divergent branches')
  then
    notify(
      'Die lokalen und entfernten Branches sind auseinander gelaufen.\n\n'
      .. 'Für diesen Pull wird Merge verwendet (--no-rebase).\n\n'
      .. 'Falls Git weiterhin eine Strategie verlangt, kannst du einmalig '
      .. 'ausführen:\n'
      .. 'git config --global pull.rebase false',
      vim.log.levels.WARN,
      { timeout = 15000 }
    )

    refresh_gitsigns()
    return
  end

  ---------------------------------------------------------------------------
  -- Authentifizierung
  ---------------------------------------------------------------------------

  if output:match('Authentication failed')
    or output:match('Invalid username or token')
    or output:match('could not read Username')
    or output:match('Permission denied')
    or output:match('Repository not found')
  then
    notify(
      'Git-Anmeldung oder Zugriff auf das Remote-Repository fehlgeschlagen.\n\n'
      .. 'Bitte Zugangsdaten, Token oder Repository-Berechtigungen prüfen.',
      vim.log.levels.ERROR,
      { timeout = 15000 }
    )

    refresh_gitsigns()
    return
  end

  ---------------------------------------------------------------------------
  -- Netzwerk
  ---------------------------------------------------------------------------

  if output:match('Could not resolve host')
    or output:match('Failed to connect')
    or output:match('Connection timed out')
    or output:match('Connection refused')
    or output:match('Network is unreachable')
  then
    notify(
      'Keine Verbindung zum Remote-Repository möglich.\n\n'
      .. 'Bitte Internetverbindung und Remote-Adresse prüfen.',
      vim.log.levels.ERROR,
      { timeout = 15000 }
    )

    refresh_gitsigns()
    return
  end

  ---------------------------------------------------------------------------
  -- Kein Git Repository
  ---------------------------------------------------------------------------

  if output:match('not a git repository')
    or output:match('does not appear to be a git repository')
  then
    notify(
      'Dieses Verzeichnis ist kein gültiges Git-Repository.',
      vim.log.levels.ERROR
    )

    refresh_gitsigns()
    return
  end

  ---------------------------------------------------------------------------
  -- Kein Remote
  ---------------------------------------------------------------------------

  if output:match('No remote repository specified')
    or output:match('No configured push destination')
    or output:match('does not appear to be a git repository')
  then
    notify(
      'Kein gültiges Remote-Repository konfiguriert.',
      vim.log.levels.ERROR
    )

    refresh_gitsigns()
    return
  end

  ---------------------------------------------------------------------------
  -- Kein Upstream
  ---------------------------------------------------------------------------

  if output:match('no tracking information')
    or output:match('has no upstream branch')
    or output:match('no upstream configured')
  then
    notify(
      'Für diesen Branch ist kein Upstream konfiguriert.\n\n'
      .. 'Beispiel:\n'
      .. 'git push -u origin <branch>',
      vim.log.levels.WARN,
      { timeout = 15000 }
    )

    refresh_gitsigns()
    return
  end

  ---------------------------------------------------------------------------
  -- Lokale Änderungen würden überschrieben
  ---------------------------------------------------------------------------

  if output:match('would be overwritten by merge')
    or output:match('Your local changes to the following files would be overwritten')
  then
    notify(
      'Pull abgebrochen.\n\n'
      .. 'Lokale Änderungen würden durch den Pull überschrieben.\n\n'
      .. 'Bitte Änderungen committen oder stashen.',
      vim.log.levels.WARN,
      { timeout = 15000 }
    )

    refresh_gitsigns()
    return
  end

  ---------------------------------------------------------------------------
  -- Lokale Änderungen / unstaged files
  ---------------------------------------------------------------------------

  if output:match('Please commit your changes or stash them')
    or output:match('commit or stash them')
  then
    notify(
      'Pull abgebrochen.\n\n'
      .. 'Es gibt lokale Änderungen, die zuerst commitet oder gestasht werden müssen.',
      vim.log.levels.WARN,
      { timeout = 15000 }
    )

    refresh_gitsigns()
    return
  end

  ---------------------------------------------------------------------------
  -- Branch / Remote nicht gefunden
  ---------------------------------------------------------------------------

  if output:match('Couldn.t find remote ref')
    or output:match('remote ref does not exist')
    or output:match('fatal: couldn.t find remote ref')
  then
    notify(
      'Der angeforderte Remote-Branch wurde nicht gefunden.',
      vim.log.levels.ERROR
    )

    refresh_gitsigns()
    return
  end

  ---------------------------------------------------------------------------
  -- Sonstiger Git-Fehler
  ---------------------------------------------------------------------------

  local message = output

  if message == '' then
    message = 'Unbekannter Fehler.'
  end

  notify(
    'Git Pull fehlgeschlagen:\n\n' .. message,
    vim.log.levels.ERROR,
    { timeout = 20000 }
  )

  ---------------------------------------------------------------------------
  -- Gitsigns aktualisieren
  ---------------------------------------------------------------------------

  refresh_gitsigns()
end
