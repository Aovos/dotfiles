-- ==========================================================================
-- SCRIPT MODULE: close_tab
-- Zuständigkeit: Schließt Tabs/Terminals sicher mit intelligentem Absturz-Schutz
-- ==========================================================================

return function()
  if vim.bo.buftype == "terminal" then
    vim.cmd("bd!")
  else
    local current_buf = vim.api.nvim_get_current_buf()
    local listed_buffers = vim.fn.getbufinfo({ buflisted = 1 })
    
    if #listed_buffers > 1 then
      -- Mehrere Tabs offen: Erst sicher zum nächsten wechseln, dann den alten löschen
      vim.cmd("BufferLineCycleNext")
      vim.cmd("bd! " .. current_buf)
    else
      -- Letzter verbleibender Tab: Neuen leeren Buffer öffnen, alten löschen (verhindert Absturz)
      vim.cmd("enew")
      vim.cmd("bd! " .. current_buf)
    end
  end
end

