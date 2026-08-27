-- ==========================================================================
-- SCRIPT MODULE: delete_target
-- Zuständigkeit: Datei oder Ordner permanent löschen (Mit Sicherheitsabfrage)
-- ==========================================================================

-- Interne atomare Hilfsfunktion: Holt den Pfad des aktuellen Fokus (Editor / Neo-Tree)
local function get_target_path()
  if vim.bo.filetype == "neo-tree" then
    local node = require("neo-tree.sources.manager").get_state("filesystem").tree:get_node()
    return node and node.path or nil
  end
  local buf_name = vim.api.nvim_buf_get_name(0)
  return buf_name ~= "" and buf_name or nil
end

return function()
  local target = get_target_path()
  if not target then 
    return vim.api.nvim_echo({{ "✗ Kein Löschziel gefunden!", "DiagnosticError" }}, true, {}) 
  end
  
  -- Sicherheitsabfrage generieren
  if vim.fn.input("'" .. vim.fn.fnamemodify(target, ":t") .. "' permanent löschen? (y/n): "):lower() == "y" then
    local is_tree = vim.bo.filetype == "neo-tree"
    local current_buf = vim.api.nvim_get_current_buf()

    -- Löschvorgang auf der Festplatte ausführen ("rf" löscht Dateien UND Ordner rekursiv)
    if pcall(function() vim.fn.delete(target, "rf") end) then
      if is_tree then 
        require("neo-tree.sources.manager").refresh("filesystem") 
      else
        -- Tab-Schutz anwenden, damit Neovim nicht abstürzt
        local listed_buffers = vim.fn.getbufinfo({ buflisted = 1 })
        if #listed_buffers > 1 then
          vim.cmd("BufferLineCycleNext")
          vim.cmd("bd! " .. current_buf)
        else
          vim.cmd("enew")
          vim.cmd("bd! " .. current_buf)
        end
      end
      vim.api.nvim_echo({{ "✓ Erfolgreich gelöscht!", "DiagnosticOk" }}, true, {})
    else
      vim.api.nvim_echo({{ "✗ Fehler beim Löschen auf Festplatte!", "DiagnosticError" }}, true, {})
    end
  end
end
