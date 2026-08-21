return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    "MunifTanjim/nui.nvim",
  },
  config = function()
    local function apply_neotree_transparency()
      vim.api.nvim_set_hl(0, "NeoTreeNormal", { bg = "NONE", ctermbg = "NONE" })
      vim.api.nvim_set_hl(0, "NeoTreeNormalNC", { bg = "NONE", ctermbg = "NONE" })
      vim.api.nvim_set_hl(0, "NeoTreeWinSeparator", { fg = "#3b4252", bg = "NONE" })
    end

    apply_neotree_transparency()

    vim.api.nvim_create_autocmd("ColorScheme", {
      group = vim.api.nvim_create_augroup("UserNeoTreeAppearance", { clear = true }),
      callback = apply_neotree_transparency,
    })

    require("neo-tree").setup({
      close_if_last_window = true,
      popup_border_style = "rounded",
      enable_diagnostics = false,

      default_component_configs = {
        indent = {
          with_markers = true,
          indent_marker = "│",
          last_indent_marker = "└",
        },
        icon = {
          folder_closed = "",
          folder_open = "",
          folder_empty = "  ",
          default = "*",
        },
        git_status = {
          symbols = {
            added     = "✚",
            modified  = "",
            deleted   = "✖",
            renamed   = "➜",
            untracked = "",
            ignored   = "◌",
            unstaged  = "✗",
            staged    = "✓",
            conflict  = "",
          },
        },
      },

      filesystem = {
        filtered_items = {
          visible = false,
          hide_dotfiles = true,
          hide_gitignored = true,
        },
        follow_current_file = {
          enabled = true,
        },
        use_libuv_file_watcher = true,
      },

      window = {
        position = "left",
        width = 35,
        mappings = {
          ["<space>"] = "none",
        }
      }
    })
  end
}
