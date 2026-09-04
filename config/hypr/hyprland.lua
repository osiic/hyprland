-- Hyprland Lua Configuration (Hyprland v0.56+)

-- Monitors
hl.monitor({
    output = "",
    mode = "preferred",
    position = "auto",
    scale = "1.0",
})

-- Environment Variables
hl.env("XDG_CURRENT_DESKTOP", "Hyprland")
hl.env("XDG_SESSION_TYPE", "wayland")
hl.env("XDG_SESSION_DESKTOP", "Hyprland")
hl.env("QT_QPA_PLATFORM", "wayland;xcb")
hl.env("QT_WAYLAND_DISABLE_WINDOWDECORATION", "1")
hl.env("GDK_BACKEND", "wayland,x11,*")
hl.env("CLUTTER_BACKEND", "wayland")
hl.env("ELECTRON_OZONE_PLATFORM_HINT", "auto")

-- Autostart Services
hl.on("hyprland.start", function()
    hl.exec_cmd("dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")
    hl.exec_cmd("systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")
    hl.exec_cmd("/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1")
    hl.exec_cmd("quickshell")
    hl.exec_cmd("swaybg -m fill -i ~/.config/hypr/hong-kong-night.jpg")
end)

-- Input & General Options
hl.config({
    input = {
        kb_layout = "us",
        follow_mouse = 1,
        sensitivity = 0,
        touchpad = {
            natural_scroll = true,
            tap_to_click = true,
            tap_and_drag = true,
            drag_lock = false,
            disable_while_typing = true,
            scroll_factor = 1.0,
            middle_button_emulation = false,
        },
    },
    gestures = {
        workspace_swipe_distance = 300,
        workspace_swipe_invert = true,
        workspace_swipe_min_speed_to_force = 30,
        workspace_swipe_cancel_ratio = 0.5,
        workspace_swipe_create_new = true,
    },
    general = {
        gaps_in = 4,
        gaps_out = 10,
        border_size = 2,
        ["col.active_border"] = "rgb(58a6ff)",
        ["col.inactive_border"] = "rgba(1f2430aa)",
        layout = "dwindle",
    },
    misc = {
        disable_hyprland_logo = true,
        force_default_wallpaper = 0,
    },
    decoration = {
        rounding = 8,
        blur = {
            enabled = true,
            size = 4,
            passes = 2,
        },
        shadow = {
            enabled = false,
        },
    },
    dwindle = {
        preserve_split = true,
    },
})

-- Gestures (Workspace Swipe 3 fingers horizontal)
hl.gesture({
    fingers = 3,
    direction = "horizontal",
    action = "workspace",
})

-- Animation Curves
hl.curve("myBezier", {
    type = "bezier",
    points = { { 0.05, 0.9 }, { 0.1, 1.05 } },
})

-- Animations
hl.animation({ leaf = "windows", enabled = true, speed = 5, bezier = "myBezier", style = "popin 80%" })
hl.animation({ leaf = "windowsOut", enabled = true, speed = 5, bezier = "myBezier", style = "popin 80%" })
hl.animation({ leaf = "border", enabled = true, speed = 8, bezier = "myBezier" })
hl.animation({ leaf = "fade", enabled = true, speed = 5, bezier = "myBezier" })
hl.animation({ leaf = "workspaces", enabled = true, speed = 5, bezier = "myBezier" })

-- Window Rules
hl.window_rule({
    match = { class = "^(com\\.mitchellh\\.ghostty)$" },
    opacity = "0.95 0.90",
})
hl.window_rule({
    match = { class = "^(org\\.gnome\\.Nautilus)$" },
    opacity = "0.98 0.92",
})

-- App Keybinds
hl.bind("SUPER + T", function() hl.exec_cmd("ghostty") end)
hl.bind("SUPER + B", function() hl.exec_cmd("microsoft-edge-stable") end)
hl.bind("SUPER + SHIFT + X", hl.dsp.window.close())
hl.bind("SUPER + L", function() hl.exec_cmd("swaylock") end)
hl.bind("SUPER + X", function() hl.exec_cmd("quickshell ipc call shell togglePowerMenu") end)
hl.bind("SUPER + C", function() hl.exec_cmd("quickshell ipc call shell toggleControlCenter") end)
hl.bind("SUPER + M", function() hl.exec_cmd("quickshell ipc call shell toggleMedia") end)
hl.bind("SUPER + SHIFT + M", hl.dsp.exit())
hl.bind("SUPER + E", function() hl.exec_cmd("nautilus") end)
hl.bind("SUPER + V", hl.dsp.window.float())
hl.bind("SUPER + SPACE", function() hl.exec_cmd("quickshell ipc call shell toggleLauncher") end)
hl.bind("SUPER + P", hl.dsp.window.pseudo())
hl.bind("SUPER + J", hl.dsp.layout("togglesplit"))
hl.bind("SUPER + S", function() hl.exec_cmd('grim -g "$(slurp)" - | swappy -f -') end)

-- Hardware Keys
hl.bind("XF86AudioMute", function() hl.exec_cmd("pamixer -t") end)
hl.bind("XF86AudioLowerVolume", function() hl.exec_cmd("pamixer -d 5") end)
hl.bind("XF86AudioRaiseVolume", function() hl.exec_cmd("pamixer -i 5") end)
hl.bind("XF86AudioMicMute", function() hl.exec_cmd("pamixer --default-source -t") end)
hl.bind("XF86MonBrightnessDown", function() hl.exec_cmd("brightnessctl set 10%-") end)
hl.bind("XF86MonBrightnessUp", function() hl.exec_cmd("brightnessctl set 10%+") end)

-- Focus Movement
hl.bind("SUPER + left", hl.dsp.focus({ direction = "left" }))
hl.bind("SUPER + right", hl.dsp.focus({ direction = "right" }))
hl.bind("SUPER + up", hl.dsp.focus({ direction = "up" }))
hl.bind("SUPER + down", hl.dsp.focus({ direction = "down" }))

-- Switch Workspaces
for i = 1, 9 do
    local str_i = tostring(i)
    hl.bind("SUPER + " .. str_i, hl.dsp.focus({ workspace = str_i }))
    hl.bind("SUPER + SHIFT + " .. str_i, hl.dsp.window.move({ workspace = str_i }))
end
hl.bind("SUPER + 0", hl.dsp.focus({ workspace = "10" }))
hl.bind("SUPER + SHIFT + 0", hl.dsp.window.move({ workspace = "10" }))

-- Mouse binds
hl.bind("SUPER + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind("SUPER + mouse_up", hl.dsp.focus({ workspace = "e-1" }))
