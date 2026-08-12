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
  
  -- Neue Shortcuts direkt unter Git
  { "<leader>gp", "<cmd>!git push<cr>",             desc = "Push to GitHub" },
  { "<leader>gc", function()
    local msg = vim.fn.input('Commit Message: ')
    if msg ~= "" then
      vim.cmd('!git commit -m "' .. msg .. '"')
    end
  end, desc = "Commit" },

  -- Dein erweitertes Staging-Untermenü mit Auswahlmöglichkeit
  { "<leader>gs", group = "Stage..." },
  { "<leader>gsa", "<cmd>!git add .<cr>",            desc = "Stage All (git add .)" },
  { "<leader>gss", "<cmd>Gitsigns stage_buffer<cr>", desc = "Stage Current File" },
  { "<leader>gsS", "<cmd>!git reset<cr>",            desc = "Unstage All" },

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
