-- [[ Modul: Monitore - modules/monitors.lua ]] --

-- 1. Externe Monitore (Plug & Play)
-- Trifft auf jeden neu angeschlossenen Bildschirm zu.
-- Nutzt immer die optimale ("preferred") Auflösung des Geräts.
hl.monitor({
  output = "", 
  mode = "preferred",
  position = "auto", -- Setzt den externen Monitor als primären Startpunkt
  scale = 1,
})

-- 2. Dein Haupt-Laptop-Bildschirm (eDP-1)
-- Nutzt ebenfalls die optimale ("preferred") Auflösung des Laptops.
-- Schaltet die Ausgabe automatisch ab, wenn ein externer Monitor aktiv ist.
hl.monitor({
  output = "eDP-1",
  mode = "preferred",
  position = "auto",
  scale = 1,
  disabled = false, -- Bleibt aktiv, wenn kein anderer Monitor da ist
})
