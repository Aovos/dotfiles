-- lua/scripts/toggle_comment.lua
local M = {}

-- Hilfsfunktion für Fallback-Kommentarzeichen
local function ensure_commentstring()
  if vim.bo.commentstring == "" then
    vim.bo.commentstring = "# %s"
  end
end

-- Funktion für den Normal Mode (aktuelle Zeile)
function M.normal_mode()
  ensure_commentstring()
  local current_line = vim.api.nvim_win_get_cursor(0)
  require("vim._comment").toggle_lines(current_line, current_line)
end

-- Funktion für den Visual Mode (Auswahl)
function M.visual_mode()
  ensure_commentstring()
  local start_line = vim.fn.line("v")
  local end_line = vim.fn.line(".")
  
  if start_line > end_line then
    start_line, end_line = end_line, start_line
  end
  
  require("vim._comment").toggle_lines(start_line, end_line)
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "n", true)
end

-- Funktion für den Insert Mode (Zeile kommentieren, im Schreibmodus bleiben)
function M.insert_mode()
  ensure_commentstring()
  local current_line = vim.api.nvim_win_get_cursor(0)
  require("vim._comment").toggle_lines(current_line, current_line)
end

return M
