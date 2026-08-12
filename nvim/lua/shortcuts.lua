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
  { "<leader>gb", "<cmd>Gitsigns blame<cr>",        desc = "Blame" }, -- 🌟 CLEAN ENGLISH
  { "<leader>gd", "<cmd>Gitsigns diffthis<cr>",      desc = "Diff" },  -- 🌟 CLEAN ENGLISH

  -- Sektion für das Datei-Staging
  { "<leader>gs", group = "Stage..." },
  { "<leader>gss", "<cmd>Gitsigns stage_buffer<cr>", desc = "Gesamte Datei für Git stagen" },
  { "<leader>gsS", "<cmd>Gitsigns reset_buffer_index<cr>", desc = "Gesamte Datei vom Staging entfernen" },

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
