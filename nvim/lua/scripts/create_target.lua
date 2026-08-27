-- ==========================================================================
-- SCRIPT MODULE: create_target
-- Zuständigkeit: Neue Datei oder neuen Ordner/Pfad am aktuellen Fokus anlegen
-- ==========================================================================

-- Interne atomare Hilfsfunktion: Holt das aktuelle Verzeichnis (Editor / Neo-Tree)
local function get_current_dir()
  if vim.bo.filetype == "neo-tree" then
    local node = require("neo-tree.sources.manager").get_state("filesystem").tree:get_node()
    if node then
      return node.type == "directory" and node.path or vim.fn.fnamemodify(node.path, ":h")
    end
  end
  local buf_name = vim.api.nvim_buf_get_name(0)
  if buf_name ~= "" then return vim.fn.fnamemodify(buf_name, ":h") end
  return vim.fn.getcwd()
end

return function(type)
  local base_dir = get_current_dir()
  local name = vim.fn.input(type == "file" and "Dateiname: " or "Ordnername / Pfad: ")
  if name == "" then return end
  local full_path = base_dir .. "/" .. name

  if type == "file" then
    -- Verzeichnisse automatisch miterstellen, falls im Pfad angegeben
    vim.fn.mkdir(vim.fn.fnamemodify(full_path, ":h"), "p")
    local file = io.open(full_path, "w")
    if file then 
      file:close() 
      vim.cmd("edit " .. vim.fn.fnameescape(full_path)) 
    end
  else
    -- Ganze Ordnerstruktur anlegen
    vim.fn.mkdir(full_path, "p")
  end
  
  -- Neo-Tree live aktualisieren, damit die Änderung sofort sichtbar ist
  require("neo-tree.sources.manager").refresh("filesystem")
end

