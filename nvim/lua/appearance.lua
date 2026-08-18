
-- ==========================================================================
-- APPEARANCE (Optimiert & Sicher)
-- ==========================================================================

-- 1. Transparenz & Farben sicher anwenden (auch nach Colorscheme-Wechsel)
vim.api.nvim_create_autocmd("ColorScheme", {
  group = vim.api.nvim_create_augroup("UserAppearance", { clear = true }),
  callback = function()
    -- Terminal-Transparenz einrichten
    local groups = { "Normal", "NormalFloat", "NormalNC", "SignColumn", "FloatBorder", "WinBar", "WinBarNC" }
    for _, group in ipairs(groups) do
      vim.api.nvim_set_hl(0, group, { bg = "NONE", ctermbg = "NONE" })
    end

    -- Diagnostics-Farben definieren
    vim.api.nvim_set_hl(0, "DiagnosticError", { fg = "#990000", bg = "NONE", bold = true })
    vim.api.nvim_set_hl(0, "DiagnosticWarn",  { fg = "#d47a2a", bg = "NONE" })

    -- Git-Farben für Gitsigns-Plugin
    local git_colors = {
      GitSignsAdd          = { fg = "#00ff00", bg = "NONE", bold = true },
      GitSignsChange       = { fg = "#00aaff", bg = "NONE", bold = true },
      GitSignsDelete       = { fg = "#ff0000", bg = "NONE", bold = true },
      GitSignsChangedelete = { fg = "#00aaff", bg = "NONE", bold = true },
      GitSignsUntracked    = { fg = "#00ff00", bg = "NONE", bold = true },
    }
    for group, opts in pairs(git_colors) do
      vim.api.nvim_set_hl(0, group, opts)
    end
  end,
})

-- Trigger das Event einmal direkt beim Start
vim.cmd("doautocmd ColorScheme")

-- 2. Diagnostics Verhalten und Design konfigurieren
vim.diagnostic.config({
  severity_sort = true,
  update_in_insert = false, -- Verhindert störende Popups mitten im Tippen
  virtual_text = { severity = { min = vim.diagnostic.severity.WARN } },
  signs = {
    severity = { min = vim.diagnostic.severity.WARN },
    text = {
      [vim.diagnostic.severity.ERROR] = "● ",
      [vim.diagnostic.severity.WARN]  = "○ "
    }
  },
  float = { border = "rounded", source = "always" },
})

-- 3. Diagnostic Pop-up automatisch öffnen (NUR im Normal-Modus!)
vim.api.nvim_create_autocmd("CursorHold", {
  group = vim.api.nvim_create_augroup("DiagnosticFloat", { clear = true }),
  callback = function()
    -- Schneller Performance-Check der Buffer-Typen
    local buftype = vim.bo.buftype
    if buftype == "terminal" or buftype == "nofile" then return end
    
    -- Prüfen, ob überhaupt Diagnostics in der aktuellen Zeile existieren
    local lnum = vim.api.nvim_win_get_cursor(0)[1] - 1
    local diagnostics = vim.diagnostic.get(0, { lnum = lnum })
    if #diagnostics == 0 then return end

    vim.diagnostic.open_float(nil, {
      focusable = false,
      close_events = { "CursorMoved", "CursorMovedI", "BufHidden", "InsertCharPre" }
    })
  end,
})

-- 4. WinBar-Abstand für gültige Buffer aktivieren
vim.api.nvim_create_autocmd({ "BufWinEnter", "WinNew" }, {
  group = vim.api.nvim_create_augroup("WinBarSpace", { clear = true }),
  callback = function()
    vim.schedule(function()
      -- Abfangen von ungültigen Buffern oder speziellen Plugins
      if not vim.api.nvim_buf_is_valid(0) then return end
      
      local ft = vim.bo.filetype
      local bt = vim.bo.buftype
      
      if ft ~= "neo-tree" and bt ~= "terminal" and bt ~= "nofile" and ft ~= "toggleterm" then
        vim.opt_local.winbar = " "
      end
    end)
  end,
})
