return {
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' }, -- Wichtig für Datei-Icons
    config = function()
      require('lualine').setup({
        options = {
          theme = 'auto',            -- Passt sich deinem Farbschema an
          globalstatus = true,       -- EINE feste Leiste ganz unten
          icons_enabled = true,      -- Aktiviert deine Icons
          section_separators = { left = '', right = '' }, 
          component_separators = { left = '', right = '' },
        },
        sections  = {
          -- LINKER BEREICH
          lualine_a = { 
            {
              function()
                -- Holt den aktuellen Modus-Namen (z.B. "NORMAL") und nimmt nur den 1. Buchstaben ("N")
                return string.sub(require('lualine.utils.mode').get_mode(), 1, 1)
              end,
            }
          },                                 
          lualine_b = { 
            { 'filename', path = 1 },                             -- Relativer Pfad + Dateiname
            'branch'                                              -- 🌿 NEU: Zeigt dauerhaft deinen aktuellen Git-Branch an
          }, 
          lualine_c = { 'diff' },                                 -- Git Änderungen (+ / ~ / -)

          -- RECHTER BEREICH
          lualine_x = { 'filetype' },                             -- Dateityp (z.B. Lua, Python)
          lualine_y = { 'diagnostics' },                          -- LSP Fehler & Warnungen
          lualine_z = { 'progress', 'location' },                 -- Fortschritt % und Zeile:Spalte
        },
      })
    end
  }
}

