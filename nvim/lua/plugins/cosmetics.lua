-- ==========================================================================
-- PLUGINS: COSMETICS (Komfort- und UI-Erweiterungen)
-- ==========================================================================

return {
  -- 1. WHICH-KEY (Die visuelle Menü-Infrastruktur)
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    config = function()
      -- Initialisiert nur das Plugin-Verhalten (Die Shortcuts liegen in shortcuts.lua)
      require("which-key").setup({
        delay = 200
      })
    end
  },

  -- 2. INDENT-BLANKLINE (Die vertikalen Führungslinien für Code-Blöcke)
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      -- Highlights für die Linien setzen
      vim.api.nvim_set_hl(0, "IblIndent", { fg = "#3b4252", nocombine = true })
      vim.api.nvim_set_hl(0, "IblScope",  { fg = "#5e81ac", nocombine = true })

      require("ibl").setup({
        indent = { char = "│", highlight = "IblIndent" },
        scope = {
          enabled = true,
          char = "┃",
          highlight = "IblScope",
          show_exact_scope = true
        },
        exclude = {
          filetypes = {
            "help", "dashboard", "lazy", "mason", "telescope", "notify", "toggleterm",
            "markdown" -- "markdown" ausgeschlossen, damit Linien das Live-Preview nicht stören
          }
        }
      })
    end
  },

  -- 3. ULTIMATE-AUTOPAIR (Automatisches Schließen von Klammern und Anführungszeichen)
  {
    "altermo/ultimate-autopair.nvim",
    event = { "InsertEnter", "CmdlineEnter" },
    config = function()
      require("ultimate-autopair").setup({})
    end
  },
}
