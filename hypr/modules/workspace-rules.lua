-- [[ Modul: Arbeitsbereich-Zuweisungen - modules/workspace-rules.lua ]] --
-- TIPP: Nutze "hyprctl clients" im Terminal, um Klassen/Titel herauszufinden

-- Workspace 1: Web
hl.window_rule({ match = { class = "firefox" }, workspace = "1 silent" })

-- Workspace 2: Mail
hl.window_rule({ match = { class = "thunderbird" }, workspace = "2 silent" })
hl.window_rule({ match = { class = "chrome-eoficlgicibekocmfdomjbfnjmehnhcd-Default" }, workspace = "2 silent" })


-- Workspace 3: Chat
hl.window_rule({ match = { class = "discord" }, workspace = "3 silent" })
hl.window_rule({ match = { class = "signal" },  workspace = "3 silent" })
hl.window_rule({ match = { class = "teams-for-linux" },  workspace = "3 silent" })

-- Workspace 4: Files
hl.window_rule({ match = { class = "nemo" }, workspace = "4 silent" })
hl.window_rule({ match = { class = "org.gnome.Nautilus" }, workspace = "4 silent" })

-- Workspace 5: Audio
hl.window_rule({ match = { class = "spotify" },   workspace = "5 silent" })
hl.window_rule({ match = { class = "audacious" }, workspace = "5 silent" })

-- Workspace 6: AV-Editing / Recording
hl.window_rule({ match = { class = "com.obsproject.Studio" }, workspace = "6 silent" })
hl.window_rule({ match = { class = "tenacity" }, workspace = "6 silent" })
hl.window_rule({ match = { class = ".virt-manager-wrapped" }, workspace = "6 silent" })

-- Workspace 7: Gaming
hl.window_rule({ match = { class = "steam" }, workspace = "7 silent" })
hl.window_rule({ match = { class = "libreoffice-writer" }, workspace = "7 silent" })
hl.window_rule({ match = { class = "libreoffice-calc" }, workspace = "7 silent" })
hl.window_rule({ match = { class = "com.github.xournalpp.xournalpp" }, workspace = "7 silent" })

-- Workspace 8: Code
hl.window_rule({ match = { class = "codium" }, workspace = "8 silent" })

-- Workspace 9: Notes
hl.window_rule({ match = { class = "marktext" }, workspace = "9 silent" })
hl.window_rule({ match = { class = "anki" }, workspace = "9 silent" })

-- Workspace 10: Productivity
hl.window_rule({ match = { class = "superproductivity" }, workspace = "10 silent" })


-- ALLGEMEINE FIXES & OPTIMIERUNGEN --

-- Maximiere-Anfragen von Apps blockieren
hl.window_rule({
  name  = "block-maximize",
  match = { class = ".*" },
  suppress_event = "maximize",
})

-- XWayland Dropdown- / Kontextmenü-Fix (z.B. für JetBrains, Spotify, etc.)
hl.window_rule({
  name  = "xwayland-menu-fix",
  match = {
    class      = "^$",
    title      = "^$",
    xwayland   = true,
    float      = true,
    fullscreen = false,
    pin        = false,
  },
  no_initial_focus = true,
})
