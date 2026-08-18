return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    "MunifTanjim/nui.nvim",
  },
  config = function()
    vim.api.nvim_create_autocmd("ColorScheme", {
      group = vim.api.nvim_create_augroup("UserNeoTreeAppearance", { clear = true }),
      callback = function()
        vim.api.nvim_set_hl(0, "NeoTreeNormal", { bg = "NONE", ctermbg = "NONE" })
        vim.api.nvim_set_hl(0, "NeoTreeNormalNC", { bg = "NONE", ctermbg = "NONE" })
        vim.api.nvim_set_hl(0, "NeoTreeWinSeparator", { fg = "#3b4252", bg = "NONE" })
      end,
    })

    vim.cmd("doautocmd ColorScheme")

    require("neo-tree").setup({
      close_if_last_window = true,
      popup_border_style = "rounded",

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
        width = 45,
        mappings = {
          ["<space>"] = "none",
        }
      }
    })
  end
}
