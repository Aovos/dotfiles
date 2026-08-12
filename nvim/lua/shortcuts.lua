-- ==========================================================================
-- SHORTCUTS (Das zentrale Which-Key Menü für alle deine Aktionen)
-- ==========================================================================

local wk = require("which-key")

-- Dein komplettes Menü strukturiert aufbauen
wk.add({
  -- 1. UNTERMENÜ: Sektion für reines Speichern
  { "<leader>s", group = "Speichern..." },
  { "<leader>ss", function() smart_save("normal") end, desc = "Datei normal Speichern" },
  { "<leader>sS", function() smart_save("as") end,     desc = "Speichern unter (Pfad angeben)" },

  -- 2. UNTERMENÜ: Sektion für deine Code-Tools (Java & C#)
  { "<leader>c", group = "Code..." },
  { "<leader>cr", smart_run_file,                   desc = "Code ausführen (Run)" },
  { "<leader>cg", smart_generate_project,           desc = "Projekt generieren (CLI)" },
  { "<leader>cf", function() vim.lsp.buf.format({ async = true }) end, desc = "Code über LSP formatieren" },

  -- 3. UNTERMENÜ: Sektion für deine Git-Werkzeuge (Live-Änderungen)
  { "<leader>g", group = "Git..." },
  { "<leader>gb", "<cmd>Gitsigns blame<cr>",        desc = "Blame" },
  { "<leader>gd", "<cmd>Gitsigns diffthis<cr>",      desc = "Diff" },
  
  -- Push mit Erfolgsmeldung
  { "<leader>gp", function()
    vim.cmd("silent !git push")
    if vim.v.shell_error == 0 then
      vim.api.nvim_echo({{ "✓ GitHub Push erfolgreich!", "DiagnosticOk" }}, true, {})
    else
      vim.api.nvim_echo({{ "✗ Fehler beim Push zu GitHub!", "DiagnosticError" }}, true, {})
    end
  end, desc = "Push to GitHub" },

  -- Commit mit Erfolgsmeldung
  { "<leader>gc", function()
    local msg = vim.fn.input('Commit Message: ')
    if msg ~= "" then
      vim.cmd('silent !git commit -m "' .. msg .. '"')
      if vim.v.shell_error == 0 then
        vim.api.nvim_echo({{ "✓ Commit erstellt: " .. msg, "DiagnosticOk" }}, true, {})
      else
        vim.api.nvim_echo({{ "✗ Fehler beim Erstellen des Commits!", "DiagnosticError" }}, true, {})
      end
    end
  end, desc = "Commit" },

  -- Dein perfekt unterteiltes Staging-Untermenü mit Erfolgsmeldungen
  { "<leader>gs", group = "Stage..." },
  
  -- Stage All mit Meldung
  { "<leader>gsa", function()
    vim.cmd("silent !git add .")
    vim.api.nvim_echo({{ "✓ Alles erfolgreich gestaged!", "DiagnosticOk" }}, true, {})
  end, desc = "Stage All (git add .)" },
  
  -- Stage Current File mit Meldung
  { "<leader>gss", function()
    vim.cmd("Gitsigns stage_buffer")
    vim.api.nvim_echo({{ "✓ Aktuelle Datei gestaged!", "DiagnosticOk" }}, true, {})
  end, desc = "Stage Current File" },
  
  -- Unstage All mit Meldung
  { "<leader>gsS", function()
    vim.cmd("silent !git reset")
    vim.api.nvim_echo({{ "✓ Staging komplett zurückgesetzt!", "DiagnosticOk" }}, true, {})
  end, desc = "Unstage All" },

  -- 4. UNTERMENÜ: Sektion für das Schließen des Editors
  { "<leader>q", group = "Schließen..." },
  { "<leader>qq", "<cmd>quit!<cr>",                  desc = "Schließen ohne Speichern" },
  { "<leader>qQ", function() smart_save("quit") end, desc = "Speichern und Schließen" },

  -- 5. HAUPEBENE: Direkt-Aktionen auf der Hauptebene
  { "<leader>f", "<cmd>Telescope find_files<cr>",   desc = "File Search" },
  { "<leader>t", "<cmd>Neotree toggle<cr>",        desc = "Dateibaum ein/ausblenden" },
  { "<C-Tab>",   "<cmd>BufferLineCycleNext<cr>",    desc = "Nächster Tab" },
  { "<C-S-Tab>", "<cmd>BufferLineCyclePrev<cr>",    desc = "Vorheriger Tab" },
})
