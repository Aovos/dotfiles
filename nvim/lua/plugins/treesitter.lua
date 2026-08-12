-- ==========================================================================
-- PLUGIN: NVIM-TREESITTER (Intelligentes Code-Parsing & Highlighting)
-- ==========================================================================

return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  config = function()
    -- Korrektur für moderne Versionen: ".configs" wurde entfernt, Setup geschieht direkt
    require("nvim-treesitter").setup({
      -- Hier sind all deine Programmiersprachen und Werkzeuge vereint
      ensure_installed = {
        -- Deine Kernsprachen
        "java",
        "c_sharp",

        -- Deine gewünschten Erweiterungen
        "python",
        "nix",
        "yaml",
        "bash",
        "json",
        "dockerfile",

        -- Für deine eigene Neovim-Config und das Markdown-Feeling
        "lua",
        "markdown",
        "markdown_inline",
        "html",
      },

      sync_install = false,

      highlight = {
        enable = true,
        additional_vim_regex_highlighting = false
      },

      indent = {
        enable = true
      }
    })
  end
}
