-- ==========================================================================
-- APPEARANCE (Reines Neovim-Aussehen - Komplett ohne Plugins!)
-- ==========================================================================

-- 1. Terminal-Transparenz einrichten
for _, group in ipairs({ "Normal", "NormalFloat", "NormalNC", "SignColumn", "FloatBorder" }) do
  vim.api.nvim_set_hl(0, group, { bg = "none", ctermbg = "none" })
end

-- 2. Diagnostics-Farben definieren
vim.api.nvim_set_hl(0, "DiagnosticError", { fg = "#990000", bg = "none", bold = true })
vim.api.nvim_set_hl(0, "DiagnosticWarn",  { fg = "#d47a2a", bg = "none" })

-- 3. Strikte Git-Farben für das vertikale Liniensystem
vim.api.nvim_set_hl(0, "GitSignsAdd",          { fg = "#00ff00", bg = "none", bold = true }) -- Reines Grün für neue Zeilen
vim.api.nvim_set_hl(0, "GitSignsChange",       { fg = "#00aaff", bg = "none", bold = true }) -- Klares Blau für normale Textänderungen
vim.api.nvim_set_hl(0, "GitSignsDelete",       { fg = "#ff0000", bg = "none", bold = true }) -- Signalrot für komplett gelöschte Zeilen
vim.api.nvim_set_hl(0, "GitSignsChangedelete", { fg = "#00aaff", bg = "none", bold = true }) -- Klares Blau für Textänderungen innerhalb einer Zeile
vim.api.nvim_set_hl(0, "GitSignsUntracked",    { fg = "#00ff00", bg = "none", bold = true }) -- Reines Grün für unversionierte Dateien

-- 4. Diagnostics Verhalten und Design konfigurieren
vim.diagnostic.config({
  severity_sort = true,
  update_in_insert = true, -- 🌟 FIX: Schaltet die Fehler-Aktualisierung live beim Tippen ein
  virtual_text = { severity = { min = vim.diagnostic.severity.WARN } },
  signs = {
    severity = { min = vim.diagnostic.severity.WARN },
    text = {
      [vim.diagnostic.severity.ERROR] = "● ",
      [vim.diagnostic.severity.WARN] = "○ "
    }
  },
  float = { border = "rounded", source = "always" },
})

-- 5. Diagnostic Pop-up automatisch öffnen
vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
  callback = function()
    vim.diagnostic.open_float(nil, {
      focusable = false,
      close_events = { "CursorMoved", "CursorMovedI", "BufHidden", "InsertCharPre" }
    })
  end,
})

-- 6. Transparente Leerzeile als Abstand unter der Tab-Leiste erzwingen
vim.api.nvim_set_hl(0, "WinBar", { bg = "none", ctermbg = "none" })
vim.api.nvim_set_hl(0, "WinBarNC", { bg = "none", ctermbg = "none" })

vim.api.nvim_create_autocmd({ "BufWinEnter", "WinNew" }, {
  callback = function()
    if vim.bo.filetype ~= "neo-tree" and vim.bo.buftype ~= "terminal" and vim.bo.buftype ~= "nofile" then
      vim.opt_local.winbar = " "
    end
  end,
})
