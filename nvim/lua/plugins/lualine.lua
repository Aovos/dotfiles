return {
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      -- Vollständig transparentes Theme (Keine bg-Werte definiert, erzwingt Terminal-Durchsicht)
      local transparent_theme = {
        normal = {
          a = { fg = '#00aaff', bg = nil, bold = true }, 
          b = { fg = '#ffffff', bg = nil },
          c = { fg = '#aaaaaa', bg = nil },
        },
        insert  = { a = { fg = '#00ff00', bg = nil, bold = true } }, 
        visual  = { a = { fg = '#d47a2a', bg = nil, bold = true } }, 
        replace = { a = { fg = '#ff0000', bg = nil, bold = true } }, 
        command = { a = { fg = '#ffffff', bg = nil, bold = true } },
        inactive = {
          a = { fg = '#666666', bg = nil },
          b = { fg = '#666666', bg = nil },
          c = { fg = '#666666', bg = nil },
        },
      }

      require('lualine').setup({
        options = {
          theme = transparent_theme, 
          globalstatus = true,       
          icons_enabled = true,
          component_separators = { left = '│', right = '│' },
          section_separators = { left = '', right = '' },
          disabled_filetypes = {
            statusline = { "neo-tree", "toggleterm" }, 
          },
        },
        sections = {
          -- LINKER BEREICH
          lualine_a = { 
            {
              function()
                local mode = vim.fn.mode():upper()
                local char = string.sub(mode, 1, 1)
                
                -- OPTION A: Eingekreiste Buchstaben (z.B. 🅝, 🅘, 🅥)
                local circled_modes = {
                  N = "🅝",
                  I = "🅘",
                  V = "🅥",
                  C = "🅒",
                  R = "🅡",
                }
                return " " .. (circled_modes[char] or char) .. " "

                -- OPTION B: Falls Option A nicht gefällt, lösche die Zeilen oben drüber
                -- und nutze diese Zeile hier (Buchstabe mit Kreis dahinter/davor):
                -- return " ◯ " .. char .. " "
              end,
            }
          },                                 
          lualine_b = { 
            { 
              'filename', 
              path = 1, 
              symbols = { modified = ' ●', readonly = ' 🔒', unnamed = '[Kein Name]' } 
            },
            { 
              'branch', 
              icon = '🌿' 
            }
          }, 
          lualine_c = { 
            { 
              'diff', 
              symbols = { added = '● ', modified = '○ ', removed = '× ' },
              diff_color = {
                added = { fg = '#00ff00' },   
                modified = { fg = '#00aaff' },
                removed = { fg = '#ff0000' },
              },
              always_visible = false, 
            } 
          },

          -- RECHTER BEREICH
          lualine_x = { 
            { 'filetype', icon_only = false } 
          },
          lualine_y = { 
            { 
              'diagnostics', 
              sources = { 'nvim_diagnostic' },
              symbols = { error = '● ', warn = '○ ', info = '» ', hint = '› ' },
              diagnostics_color = {
                error = { fg = '#990000', bold = true }, 
                warn = { fg = '#d47a2a' },
              },
            } 
          },
          lualine_z = { 
            { 'progress', separator = { right = '' } }, 
            { 'location', padding = { left = 0, right = 1 } } 
          },
        },
      })

      -- ZUSÄTZLICHER FIX: Überschreibt die globalen Statusline-Gruppen von Neovim direkt nach dem Laden
      local function reset_statusline_hl()
        vim.api.nvim_set_hl(0, "StatusLine", { bg = "NONE", ctermbg = "NONE" })
        vim.api.nvim_set_hl(0, "StatusLineNC", { bg = "NONE", ctermbg = "NONE" })
      end
      
      -- Einmal sofort ausführen und an Colorscheme-Wechsel binden
      reset_statusline_hl()
      vim.api.nvim_create_autocmd("ColorScheme", {
        callback = reset_statusline_hl,
      })
    end
  }
}

