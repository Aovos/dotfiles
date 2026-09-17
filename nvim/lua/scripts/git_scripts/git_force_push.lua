-- ==========================================================================
-- MODULE: git_force_push
-- Erzwingt den lokalen Stand auf dem Remote-Repository (Überschreibt GitHub!)
-- ==========================================================================

return function()
  local function notify(msg, level, opts)
    vim.notify(
      msg,
      level,
      vim.tbl_extend('force', { title = 'Git Force Push' }, opts or {})
    )
  end

  local function run(cmd)
    local output = vim.fn.system(cmd)
    local exit_code = vim.v.shell_error
    return vim.trim(output), exit_code
  end

  -- Sicherheitsabfrage über das Neovim-UI
  vim.ui.input({
    prompt = "Möchtest du wirklich den Server mit deinem lokalen Stand ÜBERSCHREIBEN? (ja/nein): "
  }, function(input)
    if input ~= "ja" then
      print(" Force Push abgebrochen.")
      return
    end

    print("Erzwinge Push zum Remote...")
    -- --force-with-lease schützt dich, falls jemand anderes in der Zwischenzeit gepusht hat
    local output, exit_code = run('git push --force-with-lease 2>&1')

    if exit_code == 0 then
      vim.api.nvim_echo({
        { '✓ Remote erfolgreich mit lokalem Stand überschrieben.', 'DiagnosticOk' },
      }, true, {})
    else
      if output:match("stale") or output:match("rejected") then
        notify("Push abgelehnt: Der Server hat neuere Änderungen. Nutze erst einen Fetch/Pull.", vim.log.levels.WARN)
      else
        notify("Git Force Push fehlgeschlagen:\n" .. output, vim.log.levels.ERROR)
      end
    end
  end)
end
