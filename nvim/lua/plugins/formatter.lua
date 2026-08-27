-- ==========================================================================
-- PLUGIN: CONFORM (Automatisierte Code-Formatierung für Java, C# & Markdown)
-- ==========================================================================

return {
  "stevearc/conform.nvim",
  event = { "BufWritePre" }, -- Lädt das Plugin im Hintergrund, kurz bevor gespeichert wird
  cmd = { "ConformInfo" },   -- Erlaubt den Befehl :ConformInfo zur Fehlersuche
  config = function()
    require("conform").setup({
      -- Zuweisung, welche Sprache mit welchem System-Formatter gereinigt wird
      formatters_by_ft = {
        java = { "google-java-format" }, -- Nutzt das Paket aus deiner Nix-Config
        cs = { "csharpier" },            -- Nutzt das moderne C#-Formatierungstool
        
        -- HIER DIE ERWEITERUNG FÜR MARKDOWN EINFÜGEN:
        markdown = { "prettier" },       -- Formatiert Text & rückt Tabellen sauber aus
      },

      -- Standard-Einstellungen für das Formatieren
      format_after_save = {
        lsp_format = "fallback", -- Wenn kein Formatter da ist, wird das LSP als Backup gefragt
      },
    })
  end,
}
