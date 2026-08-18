local wk = require("which-key")

local smart_save       = require("scripts.smart_save")
local run_code         = require("scripts.run_code")
local generate_project = require("scripts.generate_project")
local close_tab        = require("scripts.close_tab")
local delete_target    = require("scripts.delete_target")
local create_target    = require("scripts.create_target")
local rename_target    = require("scripts.rename_target")
local move_target      = require("scripts.move_target")

local git_stage        = require("scripts.git_scripts.git_stage")
local git_commit       = require("scripts.git_scripts.git_commit")
local git_push         = require("scripts.git_scripts.git_push")

require("scripts.terminal_setup")()

wk.add({
  { "<leader>s", group = "Speichern..." },
  { "<leader>ss", function() smart_save("normal") end, desc = "Datei normal Speichern" },
  { "<leader>sS", function() smart_save("as") end,     desc = "Speichern unter" },

  { "<leader>c", group = "Code..." },
  { "<leader>cr", run_code,                         desc = "Code ausführen (Run)" },
  { "<leader>cg", generate_project,                 desc = "Projekt generieren" },
  { "<leader>cf", function() vim.lsp.buf.format({ async = true }) end, desc = "Code formatieren" },

  { "<leader>g", group = "Git..." },
  { "<leader>gb", "<cmd>Gitsigns blame<cr>",        desc = "Blame" },
  { "<leader>gd", "<cmd>Gitsigns diffthis<cr>",     desc = "Diff" },
  { "<leader>gp", git_push,                          desc = "Push to GitHub" },
  { "<leader>gc", git_commit,                        desc = "Commit" },

  { "<leader>gs", group = "Stage..." },
  { "<leader>gsa", git_stage.stage_all,              desc = "Stage All" },
  { "<leader>gss", git_stage.stage_current,          desc = "Stage Current File" },
  { "<leader>gsS", git_stage.unstage_all,            desc = "Unstage All" },

  { "<leader>n", group = "Neu erstellen..." },
  { "<leader>nf", function() create_target("file") end, desc = "Neue Datei anlegen" },
  { "<leader>np", function() create_target("path") end, desc = "Neuen Ordner anlegen" },

  { "<leader>q", group = "Schließen..." },
  { "<leader>qq", "<cmd>quit!<cr>",                  desc = "Schließen ohne Speichern" },
  { "<leader>qQ", function() smart_save("quit") end, desc = "Speichern und Schließen" },

  { "<leader>f", "<cmd>Telescope find_files<cr>",   desc = "File Search" },
  { "<leader>l", "<cmd>Lazy<cr>",                   desc = "Lazy UI" },
  { "<leader>t", "<cmd>enew<cr>",                   desc = "Neues leeres Tab öffnen" },
  { "<leader><Tab>", "<cmd>Neotree toggle<cr>",     desc = "Dateibaum umschalten" },
  { "<leader>w", close_tab,                         desc = "Tab/Terminal sicher schließen" },
  { "<leader>r", rename_target,                     desc = "Datei/Pfad umbenennen" },
  { "<leader>x", function() move_target(false) end, desc = "Datei ausschneiden" },
  { "<leader><Insert>", function() move_target(true) end, desc = "Datei hier einfügen" },
  { "<leader><Delete>", delete_target,               desc = "Datei permanent löschen" },
  { "<C-Tab>",   "<cmd>BufferLineCycleNext<cr>",    desc = "Nächster Tab" },
  { "<C-S-Tab>", "<cmd>BufferLineCyclePrev<cr>",    desc = "Vorheriger Tab" },
})

vim.keymap.set("n", "<A-Left>",  "<cmd>wincmd h<cr>", { desc = "Fokus nach links bewegen" })
vim.keymap.set("n", "<A-Down>",  "<cmd>wincmd j<cr>", { desc = "Fokus nach unten bewegen" })
vim.keymap.set("n", "<A-Up>",    "<cmd>wincmd k<cr>", { desc = "Fokus nach oben bewegen" })
vim.keymap.set("n", "<A-Right>", "<cmd>wincmd l<cr>", { desc = "Fokus nach rechts bewegen" })

vim.keymap.set("v", "<A-Left>",  "<cmd>wincmd h<cr>", { desc = "Fokus nach links bewegen" })
vim.keymap.set("v", "<A-Down>",  "<cmd>wincmd j<cr>", { desc = "Fokus nach unten bewegen" })
vim.keymap.set("v", "<A-Up>",    "<cmd>wincmd k<cr>", { desc = "Fokus nach oben bewegen" })
vim.keymap.set("v", "<A-Right>", "<cmd>wincmd l<cr>", { desc = "Fokus nach rechts bewegen" })

vim.keymap.set("t", "<A-Left>",  "<cmd>wincmd h<cr>", { desc = "Fokus nach links bewegen" })
vim.keymap.set("t", "<A-Down>",  "<cmd>wincmd j<cr>", { desc = "Fokus nach unten bewegen" })
vim.keymap.set("t", "<A-Up>",    "<cmd>wincmd k<cr>", { desc = "Fokus nach oben bewegen" })
vim.keymap.set("t", "<A-Right>", "<cmd>wincmd l<cr>", { desc = "Fokus nach rechts bewegen" })

vim.keymap.set("v", "<C-c>", '"+y', { desc = "Kopieren (System Clipboard)" })
vim.keymap.set("v", "<leader>x", '"+x', { desc = "Text ausschneiden (System Clipboard)" })
vim.keymap.set("n", "<C-v>", '"+p', { desc = "Einfügen (Normal Modus)" })
vim.keymap.set("i", "<C-v>", '<C-r>+', { desc = "Einfügen (Insert Modus)" })
vim.keymap.set("n", "<C-a>", "<Esc>ggVG", { desc = "Alles auswählen (Normal)" })
vim.keymap.set("i", "<C-a>", "<Esc>ggVG", { desc = "Alles auswählen (Insert)" })
vim.keymap.set("v", "<C-a>", "<Esc>ggVG", { desc = "Alles auswählen (Visual)" })

vim.keymap.set("n", "<S-Up>",    "v<Up>",    { desc = "Auswahl nach oben starten" })
vim.keymap.set("n", "<S-Down>",  "v<Down>",  { desc = "Auswahl nach unten starten" })
vim.keymap.set("n", "<S-Left>",  "v<Left>",  { desc = "Auswahl nach links starten" })
vim.keymap.set("n", "<S-Right>", "v<Right>", { desc = "Auswahl nach rechts starten" })

vim.keymap.set("v", "<S-Up>",    "<Up>",    { desc = "Auswahl nach oben erweitern" })
vim.keymap.set("v", "<S-Down>",  "<Down>",  { desc = "Auswahl nach unten erweitern" })
vim.keymap.set("v", "<S-Left>",  "<Left>",  { desc = "Auswahl nach links erweitern" })
vim.keymap.set("v", "<S-Right>", "<Right>", { desc = "Auswahl nach rechts erweitern" })

vim.keymap.set("i", "<S-Up>",    "<Esc>v<Up>",    { desc = "Auswahl nach oben starten" })
vim.keymap.set("i", "<S-Down>",  "<Esc>v<Down>",  { desc = "Auswahl nach unten starten" })
vim.keymap.set("i", "<S-Left>",  "<Esc>v<Left>",  { desc = "Auswahl nach links starten" })
vim.keymap.set("i", "<S-Right>", "<Esc>v<Right>", { desc = "Auswahl nach rechts starten" })

