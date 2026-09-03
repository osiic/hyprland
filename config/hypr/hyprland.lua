-- Hyprland Modern Lua Configuration (Hyprland v0.56+)
-- Architecture: Near-Black Minimal + Quickshell Integrated UI

------------------
---- MONITORS ----
------------------
hl.monitor({
    output   = "",
    mode     = "preferred",
    position = "auto",
    scale    = 1,
})

-------------------------------
---- ENVIRONMENT VARIABLES ----
-------------------------------
hl.env("XDG_CURRENT_DESKTOP", "Hyprland")
hl.env("XDG_SESSION_TYPE", "wayland")
hl.env("XDG_SESSION_DESKTOP", "Hyprland")
hl.env("QT_QPA_PLATFORM", "wayland;xcb")
hl.env("QT_WAYLAND_DISABLE_WINDOWDECORATION", "1")
hl.env("GDK_BACKEND", "wayland,x11,*")
hl.env("CLUTTER_BACKEND", "wayland")
hl.env("ELECTRON_OZONE_PLATFORM_HINT", "auto")

-------------------
---- AUTOSTART ----
-------------------
hl.exec_once("dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")
hl.exec_once("systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")
hl.exec_once("/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1")
hl.exec_once("quickshell")
hl.exec_once("swaybg -m fill -i ~/.config/hypr/hong-kong-night.jpg")

-----------------------
---- LOOK AND FEEL ----
-----------------------
hl.config({
    general = {
        gaps_in  = 4,
        gaps_out = 10,
        border_size = 2,
        col = {
            active_border   = "0xff58a6ff",
            inactive_border = "0xaa1f2430",
        },
        resize_on_border = false,
        allow_tearing    = false,
        layout           = "dwindle",
    },

    decoration = {
        rounding       = 8,
        rounding_power = 2,
        active_opacity   = 0.95,
        inactive_opacity = 0.95,

        shadow = {
            enabled = false,
        },

        blur = {
            enabled  = true,
            size     = 4,
            passes   = 2,
            vibrancy = 0.1696,
        },
    },

    animations = {
        enabled = true,
    },

    dwindle = {
        preserve_split = true,
    },

    misc = {
        disable_hyprland_logo   = true,
        force_default_wallpaper = 0,
    },

    input = {
        kb_layout  = "us",
        follow_mouse = 1,
        sensitivity = 0,

        touchpad = {
            natural_scroll          = true,
            tap_to_click            = true,
            tap_and_drag            = true,
            disable_while_typing    = true,
            scroll_factor           = 1.0,
            middle_button_emulation = false,
        },
    },
})

--------------------
---- ANIMATIONS ----
--------------------
hl.curve("myBezier", { type = "bezier", points = { {0.05, 0.9}, {0.1, 1.05} } })
hl.animation({ leaf = "windows",    enabled = true, speed = 5, bezier = "myBezier" })
hl.animation({ leaf = "windowsOut", enabled = true, speed = 5, style = "popin 80%" })
hl.animation({ leaf = "border",     enabled = true, speed = 8 })
hl.animation({ leaf = "fade",       enabled = true, speed = 5 })
hl.animation({ leaf = "workspaces", enabled = true, speed = 5 })

------------------
---- GESTURES ----
------------------
hl.gesture({
    fingers   = 3,
    direction = "horizontal",
    action    = "workspace"
})

----------------------
---- WINDOW RULES ----
----------------------
hl.window_rule({
    name  = "ghostty-opacity",
    match = { class = "com.mitchellh.ghostty" },
    active_opacity   = 0.95,
    inactive_opacity = 0.90,
})

hl.window_rule({
    name  = "nautilus-opacity",
    match = { class = "org.gnome.Nautilus" },
    active_opacity   = 0.98,
    inactive_opacity = 0.92,
})

---------------------
---- KEYBINDINGS ----
---------------------
local mainMod = "SUPER"

-- Core Application Binds
hl.bind(mainMod .. " + T", hl.dsp.exec_cmd("ghostty"))
hl.bind(mainMod .. " + B", hl.dsp.exec_cmd("microsoft-edge-stable"))
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd("nautilus"))
hl.bind(mainMod .. " + SPACE", hl.dsp.exec_cmd("fuzzel"))
hl.bind(mainMod .. " + SHIFT + X", hl.dsp.window.close())
hl.bind(mainMod .. " + V", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + P", hl.dsp.window.pseudo())
hl.bind(mainMod .. " + J", hl.dsp.layout("togglesplit"))
hl.bind(mainMod .. " + S", hl.dsp.exec_cmd('grim -g "$(slurp)" - | swappy -f -'))

-- Quickshell UI Popups
hl.bind(mainMod .. " + M", hl.dsp.exec_cmd("quickshell ipc call shell togglePowerMenu"))
hl.bind(mainMod .. " + C", hl.dsp.exec_cmd("quickshell ipc call shell toggleControlCenter"))
hl.bind(mainMod .. " + L", hl.dsp.exec_cmd("swaylock"))
hl.bind(mainMod .. " + SHIFT + M", hl.dsp.exit())

-- Focus Navigation
hl.bind(mainMod .. " + left",  hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + up",    hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + down",  hl.dsp.focus({ direction = "down" }))

-- Workspace Navigation (1 - 10)
for i = 1, 10 do
    local key = i % 10
    hl.bind(mainMod .. " + " .. key,             hl.dsp.focus({ workspace = i }))
    hl.bind(mainMod .. " + SHIFT + " .. key,     hl.dsp.window.move({ workspace = i }))
end

-- Mouse Workspace Scroll & Window Drag
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up",   hl.dsp.focus({ workspace = "e-1" }))
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(),   { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Audio & Brightness Keys
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("pamixer -i 5"), { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("pamixer -d 5"), { locked = true, repeating = true })
hl.bind("XF86AudioMute",        hl.dsp.exec_cmd("pamixer -t"),    { locked = true })
hl.bind("XF86AudioMicMute",     hl.dsp.exec_cmd("pamixer --default-source -t"), { locked = true })
hl.bind("XF86MonBrightnessUp",  hl.dsp.exec_cmd("brightnessctl set 10%+"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown",hl.dsp.exec_cmd("brightnessctl set 10%-"), { locked = true, repeating = true })
