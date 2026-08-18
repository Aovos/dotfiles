-- ==========================================================================
-- PLUGIN: BUFFERLINE (Clean & Ohne Text über Neo-Tree)
-- ==========================================================================

return {
  "akinsho/bufferline.nvim",
  version = "*",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  event = "VeryLazy",
  config = function()
    require("bufferline").setup({
      options = {
        mode = "buffers",
        show_buffer_close_icons = false,
        show_close_icon = false,
        diagnostics = "nvim_lsp",

        -- Leere Funktionen blockieren den Klick fehlerfrei
        right_mouse_command = function() end,
        middle_mouse_command = function() end,

        -- Echte Leerzeichen als Trenner für das Kapsel-Design nutzen
        separator_style = { " ", " " },

        -- Schaltet die mitspringende Trennlinie/Indikator komplett aus
        indicator = {
          style = "none",
        },

        offsets = {
          {
            filetype = "neo-tree",
            text = "", -- 🔥 FIX: Text komplett entfernt für ein cleanes Layout
            text_align = "center",
            separator = false,
          }
        },
      },
    })

    -- Verpackt in eine exklusive Gruppe, damit Transparenz & Farben sauber überschrieben werden
    vim.api.nvim_create_autocmd("ColorScheme", {
      group = vim.api.nvim_create_augroup("UserBufferlineAppearance", { clear = true }),
      callback = function()
        -- Systemgruppen für das Tab-Layout abfangen (Zwingend nötig ab v0.11+)
        local native_groups = {
          "TabLine",
          "TabLineFill",
          "TabLineSel",
        }

        for _, group in ipairs(native_groups) do
          vim.api.nvim_set_hl(0, group, { bg = "NONE", ctermbg = "NONE", nocombine = true })
        end

        -- Interne Plugin-Gruppen vollständig auf transparent schalten
        local plugin_groups = {
          "BufferLineFill",
          "BufferLineBackground",
          "BufferLineTab",
          "BufferLineTabSelected",
          "BufferLineSeparator",
          "BufferLineSeparatorVisible",
          "BufferLineSeparatorSelected",
          "BufferLineOffset",
        }

        for _, group in ipairs(plugin_groups) do
          vim.api.nvim_set_hl(0, group, { bg = "NONE", ctermbg = "NONE", nocombine = true })
        end

        -- DEINE TEXT-KORREKTUR: Deine originalen Farbcodes exakt beibehalten
        -- 100% Leuchtkraft für den aktiven Tab (Strahlendes Weiß und Fettgedruckt)
        vim.api.nvim_set_hl(0, "BufferLineBufferSelected", { fg = "#ffffff", bg = "NONE", bold = true, nocombine = true })

        -- 50% Gedimmte Leuchtkraft für alle Tabs im Hintergrund (Dezentes Grau)
        vim.api.nvim_set_hl(0, "BufferLineBufferVisible",  { fg = "#666666", bg = "NONE", nocombine = true })
        vim.api.nvim_set_hl(0, "BufferLineBackground",     { fg = "#666666", bg = "NONE", nocombine = true })
      end,
    })

    -- Führt die Farbanpassungen sofort beim Start einmal aus
    vim.cmd("doautocmd ColorScheme")
  end
}
