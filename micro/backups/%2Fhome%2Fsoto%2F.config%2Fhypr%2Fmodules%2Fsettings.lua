-- [[ Modul: Systemeinstellungen und Fensterregeln - modules/settings.lua ]] --

hl.config({
  misc = {
    force_default_wallpaper = 0,     -- Schaltet Anime-Hintergrund ab
    disable_hyprland_logo   = true,  -- Schaltet das Logo ab
    disable_splash_rendering = true, -- Deaktiviert den Text unten komplett
  },
})



-- [[ Modul: Systemeinstellungen und Fensterregeln - modules/settings.lua ]] --

hl.config({
  misc = {
    force_default_wallpaper = 0,     -- Schaltet Anime-Hintergrund ab
    disable_hyprland_logo   = true,  -- Schaltet das Logo ab
    disable_splash_rendering = true, -- Deaktiviert den Text unten komplett
  },

  layerrule = {
    --"unset, waybar",                 -- Setzt blockierende Standard-Regeln zurück
    "blur, waybar",                  -- Aktiviert den Blur-Effekt hinter der Bar
    "ignorezero, waybar",            -- Verhindert Grafikfehler an den Ecken
  },
})