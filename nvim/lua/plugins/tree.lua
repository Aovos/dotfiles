-- ==========================================================================
-- PLUGIN: NEO-TREE (Der ausklappbaren Dateibaum für deine Projekte)
-- ==========================================================================

return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons", -- Nutzt deine funktionierenden Nerd-Fonts für Icons
    "MunifTanjim/nui.nvim",
  },
  config = function()
    -- Zwingt Neo-Tree, sich an dein transparentes Aussehen anzupassen
    vim.api.nvim_set_hl(0, "NeoTreeNormal", { bg = "none", ctermbg = "none" })
    vim.api.nvim_set_hl(0, "NeoTreeNormalNC", { bg = "none", ctermbg = "none" })
    vim.api.nvim_set_hl(0, "NeoTreeWinSeparator", { fg = "#3b4252", bg = "none" })

    require("neo-tree").setup({
      close_if_last_window = true, -- Schließt Neo-Tree automatisch, wenn es das letzte Fenster ist
      popup_border_style = "rounded", -- Abgerundete Ecken für Pop-ups innerhalb des Baums

      filesystem = {
        filtered_items = {
          visible = false, -- Versteckt .git Ordner standardmäßig, um die Übersicht zu wahren
          hide_dotfiles = true,
          hide_gitignored = true,
        },
        follow_current_file = {
          enabled = true, -- Der Baum springt automatisch zu der Datei, die du gerade editierst
        },
        use_libuv_file_watcher = true, -- Aktualisiert den Baum sofort, wenn Dateien im System erstellt werden
      },

      window = {
        position = "left",
        width = 30,
        mappings = {
          ["<space>"] = "none", -- Deaktiviert die Leertaste im Baum, damit dein Hauptmenü nicht blockiert wird
        }
      }
    })
  end
}
