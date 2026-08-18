-- ==========================================================================
-- SCRIPT MODULE: terminal_setup
-- Zuständigkeit: Konfiguriert Event-Steuerung und Shortcuts für offene Terminals
-- ==========================================================================

return function()
  vim.api.nvim_create_autocmd("TermOpen", {
    group = vim.api.nvim_create_augroup("UserTerminalShortcuts", { clear = true }),
    callback = function()
      -- Großes Q schließt das Terminal-Fenster UND löscht den Buffer aus der Bufferline
      vim.keymap.set("t", "Q", "<C-\\><C-n><cmd>bd!<cr>", { buffer = true, desc = "Terminal & Buffer komplett schließen" })
      
      -- ESC bringt dich im Terminal in den Normal-Modus (um z.B. im Output zu scrollen)
      vim.keymap.set("t", "<Esc>", "<C-\\><C-n>", { buffer = true, desc = "Terminal Normal-Modus" })
    end,
  })
end

