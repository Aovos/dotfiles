-- ==========================================================================
-- SCRIPT MODULE: move_target
-- Zuständigkeit: Datei/Pfad ausschneiden (merken) und an neuer Stelle einfügen
-- ==========================================================================

_G.clipboard_cut_target = nil -- Globaler Zwischenspeicher für den Quellpfad

-- Interne atomare Hilfsfunktion: Holt aktuelles Verzeichnis oder Pfad
local function get_info(get_dir)
  if vim.bo.filetype == "neo-tree" then
    local node = require("neo-tree.sources.manager").get_state("filesystem").tree:get_node()
    if not node then return nil end
    return get_dir and (node.type == "directory" and node.path or vim.fn.fnamemodify(node.path, ":h")) or node.path
  end
  local buf_name = vim.api.nvim_buf_get_name(0)
  if buf_name == "" then return get_dir and vim.fn.getcwd() or nil end
  return get_dir and vim.fn.fnamemodify(buf_name, ":h") or buf_name
end

-- Die Hauptfunktion: Erwartet 'true' zum Einfügen (Paste) oder 'false' zum Ausschneiden (Cut)
return function(is_paste)
  if is_paste then
    -- 1. EINFÜGEN (PASTE)
    if not _G.clipboard_cut_target then 
      return vim.api.nvim_echo({{ "✗ Zwischenablage leer! Keine Datei zum Verschieben vorhanden.", "DiagnosticError" }}, true, {}) 
    end
    
    local dest = get_info(true) .. "/" .. vim.fn.fnamemodify(_G.clipboard_cut_target, ":t")
    
    if os.rename(_G.clipboard_cut_target, dest) then
      -- Wenn die aktuell im Editor geöffnete Datei verschoben wurde, Buffer live updaten
      if vim.api.nvim_buf_get_name(0) == _G.clipboard_cut_target then 
        vim.cmd("bwipeout!") 
        vim.cmd("edit " .. vim.fn.fnameescape(dest)) 
      end
      
      _G.clipboard_cut_target = nil -- Zwischenspeicher nach Erfolg leeren
      require("neo-tree.sources.manager").refresh("filesystem")
      vim.api.nvim_echo({{ "✓ Datei erfolgreich verschoben!", "DiagnosticOk" }}, true, {})
    else
      vim.api.nvim_echo({{ "✗ Fehler beim Verschieben der Datei!", "DiagnosticError" }}, true, {})
    end
  else
    -- 2. AUSSCHNEIDEN (CUT)
    _G.clipboard_cut_target = get_info(false)
    if _G.clipboard_cut_target then 
      local filename = vim.fn.fnamemodify(_G.clipboard_cut_target, ":t")
      vim.api.nvim_echo({{ "✂ '" .. filename .. "' für den Umzug vorgemerkt!", "DiagnosticOk" }}, true, {}) 
    end
  end
end

