-- [[ Modul: Eingabegeräte & Gesten - modules/input.lua ]] --

-- Tastatur, Maus und Touchpad einrichten
hl.config({
  input = {
    kb_layout  = "de",
    kb_variant = "",
    kb_model   = "",
    kb_options = "",
    kb_rules   = "",

    follow_mouse = 1,

    sensitivity = 0, -- -1.0 bis 1.0, 0 bedeutet keine Veränderung

    touchpad = {
      natural_scroll       = true,
      disable_while_typing = false,
    },
  },
})

-- Touchpad-Gesten einrichten
hl.gesture({
  fingers   = 3,
  direction = "horizontal",
  action    = "workspace",
})
