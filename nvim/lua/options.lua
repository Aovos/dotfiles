local opt = vim.opt

-- Funktionale Kern-Einstellungen
opt.clipboard = "unnamedplus" -- System-Zwischenablage mit Neovim teilen
opt.mouse = "a"              -- Mausunterstützung in allen Modi aktivieren
opt.tabstop = 4              -- Ein Tab entspricht physisch 4 Leerzeichen
opt.shiftwidth = 4           -- Automatische Einrückungen sind 4 Leerzeichen breit
opt.expandtab = true         -- Drücken von 'Tab' fügt echte Leerzeichen ein
opt.updatetime = 400         -- 🔋 ACCU-SAVER: Zurück auf sichere 400ms für maximale CPU-Schonung
opt.number = true            -- Zeilennummern links anzeigen
opt.termguicolors = true     -- Schaltet echtes True-Color für Überschriften frei

-- Visuelle Korrekturen für das Fenster-Design
opt.signcolumn = "yes"              -- Feste, schlanke Spalte für Symbole (Fehler überlagern Git)
opt.fillchars:append({ eob = " " }) -- Tilden am Dateiende durch unsichtbare Leerzeichen ersetzen
opt.splitright = true               -- Vertikale Fenster-Splits standardmäßig immer rechts öffnen
