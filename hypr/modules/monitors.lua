-- [[ Modul: Monitore - modules/monitors.lua ]] --

-- Dein Haupt-Laptop-Bildschirm (eDP-1)
hl.monitor({
  output = "eDP-1",
  mode = "1920x1080@144",
  position = "0x0",
  scale = 1,
  disabled = true,
})

-- Fallback-Regel für neu angesteckte Bildschirme
hl.monitor({
  output = "",
  mode = "preferred",
  position = "auto",
  scale = 1,
})
