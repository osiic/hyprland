# hyprland
cemu setup hyprland

## Tech
- yay
- hyprland-git
- kitty: terminal
- wlogout: This is a logout menu that allows for shutdown, reboot and sleep
- ttf-jetbrains-mono-nerd: Font
- noto-fonts-emoji: fonts needed by the weather script in the top bar
- wofi: This is an application launcher menu
- brightnessctl: used to control monitor bright level
- thunar: This is a graphical file manager
- pamixer: This helps with audio settings such as volume
- gvfs: adds missing functionality to thunar such as automount usb drives
- xdg-desktop-portal-hyprland: xdg-desktop-portal backend for hyprland
- swaybg: This is used to set a desktop background image


## Script
```
yay -S hyprland-git kitty wlogout ttf-jetbrains-mono-nerd \
noto-fonts-emoji wofi brightnessctl thunar pamixer gvfs \
xdg-desktop-portal-hyprland swaybg
```
