-- [[ Modul: Monitore - modules/monitors.lua ]] --
-- Alle Monitore anzeigen lassen -> hyprctl monitors all

-- Laptop Display (eDP-1)
hl.monitor({
  output = "eDP-1",
  mode = "preferred",
  position = "0x0",
  scale = 1,
  disabled = false,
})

-- Hauptmonitor
hl.monitor({
  output = "DP-3",
  mode = "preferred",
  position = "-1920x0",
  scale = 1,
  disabled = false,
  mirror = "eDP-1"
})

-- Fallback-Regel für neu angesteckte Bildschirme
hl.monitor({
  output = "",
  mode = "preferred",
  position = "auto",
  scale = 1,
  disabled = false,
})
