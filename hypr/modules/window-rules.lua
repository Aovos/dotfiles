-- [[ Modul: Fenster-Regeln - modules/window-rules.lua ]] --
-- TIPP: Nutze "hyprctl clients" im Terminal, um Klassen/Titel herauszufinden

-- Alacritty
hl.window_rule({
  name  = "float-alacritty",
  match = { class = "Alacritty", title = "Alacritty" },
  float = true,
  size  = { 600, 400 },
})

-- Firefox Picture-in-Picture
hl.window_rule({
  name  = "firefox-pip",
  match = { class = "firefox", title = "Picture-in-Picture" },
  float = true,
  pin   = true,
})

-- MPV
hl.window_rule({
  name  = "float-mpv",
  match = { class = "mpv" },
  float = true,
})

-- Feh
hl.window_rule({
  name  = "float-feh",
  match = { class = "feh" },
  float = true,
})

-- Evince
hl.window_rule({
  name  = "evince",
  match = { class = "org.gnome.Evince" },
  float = true,
  center = true,
  size  = { 1500, 850 },
})

-- Xournal++
hl.window_rule({
  name  = "xournal++",
  match = { class = "com.github.xournalpp.xournalpp" },
  float = true,
  center = true,
  size  = { 1600, 950 },
})

-- Blueman Manager
hl.window_rule({
  name  = "blueman",
  match = { class = ".blueman-manager-wrapped" },
  float = true,
  center = true,
  size  = { 600, 400 },
})

-- Networkmanager
hl.window_rule({
  name  = "networkmanager",
  match = { class = "nm-connection-editor" },
  float = true,
  center = true,
  size  = { 800, 600 },
})

-- Pavucontrol
hl.window_rule({
  name  = "pavucontrol-center",
  match = { class = "org.pulseaudio.pavucontrol" },
  float = true,
  center = true,
  size  = { 900, 500 },
})

-- Songrec
hl.window_rule({
  name  = "songrec-center",
  match = { class = "re.fossplant.songrec" },
  float = true,
  center = true,
  size  = { 1400, 800 },
})

-- Tenacity
hl.window_rule({
  name  = "tenacity-center",
  match = { class = "tenacity" },
  float = true,
  center = true,
  size  = { 1600, 600 },
})

-- GParted
hl.window_rule({
  name  = "gparted-center",
  match = { class = "GParted" },
  float = true,
  center = true,
  size  = { 900, 600 },
})

-- MissionCenter
hl.window_rule({
  name  = "missioncenter-center",
  match = { class = "io.missioncenter.MissionCenter" },
  float = true,
  center = true,
  size  = { 1400, 900 },
})
