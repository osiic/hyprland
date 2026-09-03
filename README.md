# hyprland

Konfigurasi Wayland desktop environment berbasis Hyprland + Quickshell yang minimalis, terpadu, dan hemat memori.

## Struktur Direktori

```text
.
├── config/
│   ├── hypr/
│   │   ├── hong-kong-night.jpg
│   │   ├── hyprland.conf
│   │   └── xdg-portal-hyprland
│   └── quickshell/
│       ├── shell.qml
│       ├── Theme.qml
│       └── modules/
│           ├── Bar.qml
│           ├── BatteryIndicator.qml
│           ├── ControlCenter.qml
│           ├── Notifications.qml
│           ├── PowerMenu.qml
│           └── UpdateIndicator.qml
├── setup.sh
├── CHANGELOG.md
└── README.md
```

## Komponen Utama
- **WM:** `hyprland`
- **Unified UI Shell:** `quickshell` (Bar, System Tray, Notifikasi, Control Center, Power Menu, Battery, Updates)
- **Wallpaper:** `swaybg`
- **Terminal:** `ghostty`
- **File Manager:** `nautilus`
- **Portal:** `xdg-desktop-portal-hyprland`

## Deploy Symlinks

Jalankan via root dotfiles:
```bash
cd ~/dotfiles && ./setup.sh desktop
```
