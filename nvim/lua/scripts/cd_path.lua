-- ~/.config/nvim/lua/scripts/cd_path.lua

local M = {}

-- Funktion für das Home-Verzeichnis
function M.to_home()
  local home = os.getenv("HOME") or os.getenv("USERPROFILE")
  if home then
    vim.api.nvim_set_current_dir(home)
    print("Verzeichnis gewechselt zu Home: " .. home)
  end
end

-- Funktion für die aktuelle Datei
function M.to_file()
  local current_file = vim.api.nvim_buf_get_name(0)
  
  if current_file == "" then
    print("Keine aktive Datei gefunden!")
    return
  end

  local file_dir = vim.fs.dirname(current_file)
  
  if file_dir then
    vim.api.nvim_set_current_dir(file_dir)
    print("Verzeichnis gewechselt zu: " .. file_dir)
  end
end

return M
