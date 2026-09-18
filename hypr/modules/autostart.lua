-- [[ Modul: Autostart - modules/autostart.lua ]] --

hl.on("hyprland.start", function ()
  hl.exec_cmd("hyprpaper")                              -- Hintergrundbild-Dienst (Wallpaper)
  hl.exec_cmd("hypridle")                               -- Leerlauf-Dienst (steuert Bildschirm-Timeout / Sperrung)
  hl.exec_cmd("systemctl --user start hyprpolkitagent") -- Authentifizierungs-Agent (für Root-Rechte in GUI-Apps)
  hl.exec_cmd("hyprctl setcursor McMojave-cursors 24")  -- Setzt den Standard-Mauszeiger und dessen Größe
end)
