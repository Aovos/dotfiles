-- ==========================================================================
-- PLUGIN: TELESCOPE (Die interaktive Dateisuche)
-- ==========================================================================

return {
  "nvim-telescope/telescope.nvim",
  branch = "0.1.x",
  dependencies = {
    "nvim-lua/plenary.nvim",       -- Wichtige Lua-Bibliothek für Telescope
    "nvim-tree/nvim-web-devicons"  -- Für hübsche Icons in der Dateiliste
  },
  config = function()
    require("telescope").setup({
      defaults = {
        preview = {
          -- Schützt den v0.12+ Core vor veralteten Funktionsaufrufen
          treesitter = false,
        }
      }
    })
  end
}
