-- [[ Modul: Tastenkombinationen - modules/keybinds.lua ]] --

local mainMod = "SUPER"

-- Mausrad-Navigation in den Workspaces
hl.bind(mainMod .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" }))
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))

-- Apps und System-Aktionen
hl.bind(mainMod .. " + Return", hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + R", hl.dsp.exec_cmd(menu))
hl.bind(mainMod .. " + Q", hl.dsp.window.close()) -- "killactive" ist jetzt "close"
hl.bind(mainMod .. " + F", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + V", hl.dsp.window.fullscreen({ action = "toggle" }))
hl.bind(mainMod .. " + L", hl.dsp.exec_cmd("hyprlock"))
hl.bind(mainMod .. " + B", hl.dsp.exec_cmd('dunstify -u normal -a "System" "Battery" "$(cat /sys/class/power_supply/BAT0/capacity)% ($(cat /sys/class/power_supply/BAT0/status))" -h string:x-dunst-stack-tag:battery'))
hl.bind(mainMod .. " + T", hl.dsp.exec_cmd('dunstify -u normal -a "System" "Time & Date" "$(date +\'󰔟 %H:%M    %A, %d.%m.%Y\')" -h string:x-dunst-stack-tag:time_date'))
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd("~/Scripts/Power_profiles/rofi-power-profiles.sh"))
hl.bind(mainMod .. " + W", hl.dsp.exec_cmd("rofi-network-manager"))
hl.bind(mainMod .. " + M", hl.dsp.exec_cmd("missioncenter"))

-- Floating & Pinning kombiniert auf Taste P
hl.bind(mainMod .. " + P", function()
  hl.dispatch(hl.dsp.window.float({ action = "set" }))
  hl.dispatch(hl.dsp.window.pin()) -- pin() benötigt oft keine Argumente für 'set'
end)

-- Code-Lese-Modus (Resize + Zentrieren) auf Taste C
hl.bind(mainMod .. " + C", function()
  -- x und y müssen in der neuen API oft als Tabelle in resize übergeben werden
  hl.dispatch(hl.dsp.window.resize({ x = 1000, y = 1020, relative = false }))
  hl.dispatch(hl.dsp.window.center())
end)

-- Screenshot
hl.bind("Print", hl.dsp.exec_cmd('grim -g "$(slurp)" - | tee ~/Desktop/screenshot_$(date +%Y-%m-%d_%H-%M-%S).png | wl-copy'))
hl.bind("SHIFT + Print", hl.dsp.exec_cmd('grim -g "$(slurp)" - | satty -f - --copy-command wl-copy -o ~/Desktop/screenshot_$(date +%Y-%m-%d_%H-%M-%S).png'))

-- Fenster-FOKUS verschieben (Mit Pfeiltasten)
hl.bind(mainMod .. " + left",  hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + up",    hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + down",  hl.dsp.focus({ direction = "down" }))

-- Fenster physisch verschieben (Mit Pfeiltasten)
hl.bind(mainMod .. " + SHIFT + left",  hl.dsp.window.move({ direction = "l", swap = true }))
hl.bind(mainMod .. " + SHIFT + right", hl.dsp.window.move({ direction = "r", swap = true }))
hl.bind(mainMod .. " + SHIFT + up",    hl.dsp.window.move({ direction = "u", swap = true }))
hl.bind(mainMod .. " + SHIFT + down",  hl.dsp.window.move({ direction = "d", swap = true }))

-- Workspaces wechseln (1 - 10)
for i = 1, 9 do
  hl.bind(mainMod .. " + " .. i, hl.dsp.focus({ workspace = i }))
end
hl.bind(mainMod .. " + 0", hl.dsp.focus({ workspace = 10 }))

-- Fenster in Workspaces verschieben (1 - 10)
for i = 1, 9 do
  hl.bind(mainMod .. " + SHIFT + " .. i, hl.dsp.window.move({ workspace = i }))
end
hl.bind(mainMod .. " + SHIFT + 0", hl.dsp.window.move({ workspace = 10 }))

-- Spezial-Workspace (Scratchpad)
hl.bind(mainMod .. " + plus", hl.dsp.workspace.toggle_special("magic"))
hl.bind(mainMod .. " + SHIFT + plus", hl.dsp.window.move({ workspace = "special:magic" }))

-- Fenster mit der Maus bewegen und vergrößern
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + SHIFT + mouse:272", hl.dsp.window.resize(), { mouse = true })

-- Multimedia-Tasten (Visualisiert über Dunst mit englischen Begriffen)
local media_flags = { repeating = true, locked = true }

-- Audio-Steuerung mit Dunst-OSD (Dynamische Symbole bei Mute/Unmute)
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+ && if wpctl get-volume @DEFAULT_AUDIO_SINK@ | grep -q '[MUTED]'; then dunstify -h string:x-dunst-stack-tag:volume -h int:value:$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk '{print int($2 * 100)}') \"Volume Up (Muted)\"; else dunstify -h string:x-dunst-stack-tag:volume -h int:value:$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk '{print int($2 * 100)}') \"Volume Up\"; fi"), media_flags)
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%- && if wpctl get-volume @DEFAULT_AUDIO_SINK@ | grep -q '[MUTED]'; then dunstify -h string:x-dunst-stack-tag:volume -h int:value:$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk '{print int($2 * 100)}') \"Volume Down (Muted)\"; else dunstify -h string:x-dunst-stack-tag:volume -h int:value:$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk '{print int($2 * 100)}') \"Volume Down\"; fi"), media_flags)
hl.bind("XF86AudioMute",        hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle && if wpctl get-volume @DEFAULT_AUDIO_SINK@ | grep -q '[MUTED]'; then dunstify -h string:x-dunst-stack-tag:volume -h int:value:0 \"Muted\"; else dunstify -h string:x-dunst-stack-tag:volume -h int:value:$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk '{print int($2 * 100)}') \"Unmuted\"; fi"), media_flags)
hl.bind("XF86AudioMicMute",     hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"), media_flags)

-- Helligkeits-Steuerung mit Dunst-OSD
hl.bind("XF86MonBrightnessUp",   hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+ && dunstify -h string:x-dunst-stack-tag:brightness -h int:value:$(brightnessctl -m | awk -F, '{print int($4)}') \"Brightness Up\""), media_flags)
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%- && dunstify -h string:x-dunst-stack-tag:brightness -h int:value:$(brightnessctl -m | awk -F, '{print int($4)}') \"Brightness Down\""), media_flags)

-- Musik-Steuerung
local player_flags = { locked = true }
hl.bind("XF86AudioNext",  hl.dsp.exec_cmd("playerctl next"), player_flags)
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), player_flags)
hl.bind("XF86AudioPlay",  hl.dsp.exec_cmd("playerctl play-pause"), player_flags)
hl.bind("XF86AudioPrev",  hl.dsp.exec_cmd("playerctl previous"), player_flags)
