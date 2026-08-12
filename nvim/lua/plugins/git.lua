-- ==========================================================================
-- PLUGIN: GITSIGNS (Visuelle Git-Änderungen direkt an den Zeilennummern)
-- ==========================================================================

return {
  "lewis6991/gitsigns.nvim",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    require("gitsigns").setup({
      -- Deine Symbole für die Git-Änderungen an der linken Leiste
      signs = {
        add          = { text = "┃" }, -- Vertikaler Balken für neue Zeilen
        change       = { text = "┃" }, -- Vertikaler Balken für geänderte Zeilen
        delete       = { text = "┃" }, -- Vertikaler Balken für gelöschte Zeilen
        topdelete    = { text = "┃" }, -- Vertikaler Balken für Löschungen am Dateianfang
        changedelete = { text = "┃" }, -- Vertikaler Balken für Textänderungen in einer Zeile
        untracked    = { text = "┆" }, -- Gestrichelte Linie für unversionierte Dateien
      },

      -- Sorgt dafür, dass die Symbole perfekt neben den Zeilennummern sitzen
      signcolumn = true,

      -- Aktualisiert die Anzeige sofort beim Tippen
      watch_gitdir = {
        interval = 1000,
        follow_files = true
      },
    })
  end
}
