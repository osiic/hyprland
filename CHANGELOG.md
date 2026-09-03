# Changelog

Semua perubahan tercatat di file ini. Format mengacu pada [Keep a Changelog](https://keepachangelog.com/en/1.1.0/).

## [Unreleased]

## [3.1.0] - 2026-09-03

### Changed
- **Modern Lua Engine:** Migrasi format konfigurasi Hyprland ke engine modern `hyprland.lua` (standar Hyprland v0.55/v0.56+).
- **Cleaner Dispatchers:** Menggunakan API `hl.bind`, `hl.config`, `hl.monitor`, `hl.gesture`, dan `hl.window_rule` native Lua.

## [3.0.0] - 2026-09-03

### Changed
- **Unified UI Architecture:** Menggantikan Waybar, Mako, dan Wlogout sepenuhnya dengan Quickshell (`quickshell 0.3.1`) sebagai single-engine UI shell.
- **Near-Black Minimal Theme:** Palet tema warna terpadu (Base `#0a0b0e`, Surface `#12151b`, Border `#1f2430`, Accent `#58a6ff`).
- **Hyprland Autostart:** Menghapus autostart `waybar` & `mako`, mengaktifkan `exec-once = quickshell`.
- **Keybindings IPC:**
  - `SUPER + M`: Membuka Quickshell Power Menu (Lock, Suspend, Logout, Reboot, Shutdown).
  - `SUPER + C`: Membuka Quickshell Control Center (Volume, Brightness, Wi-Fi, Bluetooth).

### Added
- Modul Quickshell (`~/.config/quickshell/`):
  - `Bar.qml`: Status bar atas (Workspaces, Active title, Clock, Tray, Battery, Volume, Updates).
  - `Notifications.qml`: Server & popup notifikasi terpadu.
  - `ControlCenter.qml`: Panel slider audio PipeWire & brightnessctl.
  - `PowerMenu.qml`: Menu aksi sistem modal.
  - `UpdateIndicator.qml`: Pengecek paket update Arch Linux non-intrusif.
  - `BatteryIndicator.qml`: Monitor baterai dan status charging.

### Removed
- Menghapus folder `config/waybar/`.
- Menonaktifkan dependensi runtime `mako` dan `wlogout`.

## [2.2.0] - 2026-09-03
- Touchpad natural scrolling & 3-finger workspace gestures.

## [2.1.0] - 2026-09-03
- Waybar tweaks & Hyprland modern environment variables.

## [2.0.0] - 2026-09-03
- Migrasi awal Niri -> Hyprland stack.
