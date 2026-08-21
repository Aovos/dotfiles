-- ==========================================================================
-- NEOCONFIG SCHALTZENTRALE (Haupt-Einstiegspunkt)
-- ==========================================================================

-- 1. Funktionale Grundeinstellungen sofort laden
require("options")

-- 3. lazy.nvim Plugin-Manager Bootstrapper aktivieren
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "--branch=stable",
    "https://github.com",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Leader-Tasten global definieren (Wichtig: Muss VOR .setup() passieren!)
vim.g.mapleader, vim.g.maplocalleader = " ", " "

-- 4. Lazy initialisieren und den gesamten "plugins"-Ordner überwachen lassen
require("lazy").setup({
  spec = "plugins",
  install = { colorscheme = { "habamax" } },
  checker = { enabled = true },
})

-- 5. Das komplette Aussehen (Transparenz, Linien & visuelle Plugins) aktivieren
require("appearance")

-- 6. Das zentrale, verschachtelte Which-Key Shortcut-Menü füttern
require("shortcuts")
