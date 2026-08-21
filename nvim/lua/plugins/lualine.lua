return {
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      -- Transparent theme configuration (bg = nil passes through to your terminal's main background)
      local transparent_theme = {
        normal = {
          a = { fg = '#00aaff', bg = nil, bold = true }, 
          b = { fg = '#b0b0b0', bg = nil }, 
          c = { fg = '#aaaaaa', bg = nil },
        },
        insert  = { a = { fg = '#00ff00', bg = nil, bold = true } }, 
        visual  = { a = { fg = '#d47a2a', bg = nil, bold = true } }, 
        replace = { a = { fg = '#ff0000', bg = nil, bold = true } }, 
        command = { a = { fg = '#b0b0b0', bg = nil, bold = true } }, 
        inactive = {
          a = { fg = '#666666', bg = nil },
          b = { fg = '#666666', bg = nil },
          c = { fg = '#666666', bg = nil },
        },
      }

      -- Pre-defined lookup table for faster execution in the loop
      local circled_modes = {
        N = "🅝",
        I = "🅘",
        V = "🅥",
        C = "🅒",
        R = "🅡",
      }

      require('lualine').setup({
        options = {
          theme = transparent_theme, 
          globalstatus = true,       
          icons_enabled = true,
          -- Clean space layout: Separators are empty strings, letting padding create the boundaries
          component_separators = { left = '', right = '' }, 
          section_separators = { left = '', right = '' },
          disabled_filetypes = {
            statusline = { "neo-tree", "toggleterm" }, 
          },
        },
        sections = {
          -- LEFT SECTIONS
          lualine_a = { 
            {
              function()
                local mode = vim.fn.mode():upper()
                local char = string.sub(mode, 1, 1)
                return " " .. (circled_modes[char] or char) .. " "
              end,
              padding = { left = 1, right = 1 }
            }
          },                                 
          lualine_b = { 
            { 
              'filename',
              icon = '',
              path = 1, 
              symbols = { modified = ' ●', readonly = ' 🔒', unnamed = '[No Name]' },
              padding = { left = 2, right = 2 } -- Generous padding to create clean space blocks
            },
            { 
              'branch', 
              icon = '',
              padding = { left = 1, right = 2 }
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
              padding = { left = 2, right = 1 }
            } 
          },

          -- RIGHT SECTIONS
          lualine_x = { 
            { 
              'filetype', 
              icon_only = false,
              padding = { left = 1, right = 2 }
            } 
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
              padding = { left = 2, right = 2 }
            } 
          },
          lualine_z = { 
            { 'progress', separator = { right = '' }, padding = { left = 1, right = 1 } }, 
            { 'location', padding = { left = 1, right = 2 } } 
          },
        },
      })

      -- ADDITIONAL FIX: Overrides global statusline highlight groups directly after loading
      local function reset_statusline_hl()
        vim.api.nvim_set_hl(0, "StatusLine", { bg = "NONE", ctermbg = "NONE" })
        vim.api.nvim_set_hl(0, "StatusLineNC", { bg = "NONE", ctermbg = "NONE" })
      end
      
      -- Execute immediately and bind to ColorScheme alterations
      reset_statusline_hl()
      vim.api.nvim_create_autocmd("ColorScheme", {
        callback = reset_statusline_hl,
      })
    end
  }
}
