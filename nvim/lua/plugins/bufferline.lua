-- ==========================================================================
-- PLUGIN: BUFFERLINE (Die visuelle Tab-Leiste am oberen Bildschirmrand)
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

        -- Echte Leerzeichen als Trenner für das Kapsel-Design nutzen
        separator_style = { " ", " " },

        -- Schaltet die mitspringende Trennlinie/Indikator komplett aus
        indicator = {
          style = "none",
        },

        offsets = {
          {
            filetype = "neo-tree",
            text = "📁 Projekt-Struktur",
            text_align = "center",
            separator = false,
          }
        },
      },
    })

    -- Systemgruppen für das Tab-Layout abfangen (Zwingend nötig ab v0.11+)
    local native_groups = {
      "TabLine",
      "TabLineFill",
      "TabLineSel",
    }

    for _, group in ipairs(native_groups) do
      vim.api.nvim_set_hl(0, group, { bg = "none", ctermbg = "none", nocombine = true })
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
      vim.api.nvim_set_hl(0, group, { bg = "none", ctermbg = "none", nocombine = true })
    end

    -- 🌟 TEXT-KORREKTUR: Sichtbarkeit für aktive und inaktive Tabs exakt einstellen
    -- 100% Leuchtkraft für den aktiven Tab (Strahlendes Weiß und Fettgedruckt)
    vim.api.nvim_set_hl(0, "BufferLineBufferSelected", { fg = "#ffffff", bg = "none", bold = true, nocombine = true })

    -- 50% Gedimmte Leuchtkraft für alle Tabs im Hintergrund (Dezentes Grau)
    vim.api.nvim_set_hl(0, "BufferLineBufferVisible",  { fg = "#666666", bg = "none", nocombine = true })
    vim.api.nvim_set_hl(0, "BufferLineBackground",     { fg = "#666666", bg = "none", nocombine = true })
  end
}
