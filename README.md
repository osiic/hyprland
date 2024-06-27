# hyprland
cemu setup hyprland

## Tech
- yay
- hyprland-git
- waybar: Waybar now has hyprland support
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
- bluez: the bluetooth service
- bluez-utils: command line utilities to interact with bluettoth devices
- zsh 
- tmux

<br ><br >

## Script

### Update System
```
sudo pacman -Syyuu 
```

### Intall git & neovim & neofetch
```
sudo pacman -S --needed base-devel git neofetch neovim
```

### Install yay
``` cmd
cd ~
cd .config/
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
yay --version
```

### Install package
``` cmd
yay -S hyprland-git kitty wlogout ttf-jetbrains-mono-nerd \
noto-fonts-emoji wofi brightnessctl thunar pamixer gvfs \
xdg-desktop-portal-hyprland swaybg waybar zsh tmux
```

### Remap Power Button
` sudo nvim /etc/systemd/logind.conf `
```
HandlePowerKey=ignore
HandlePowerKeyLongPress=ignore
HandleLidSwitch=hibernate
PowerKeyIgnoreInhibited=yes
```
` nvim ~/.config/hypr/hyprland.conf ` 
```
bind = , xf86poweroff , exec, wlogout --protocol layar-shell 
```

### Startup Hyprland
```
sudo nvim /etc/systemd/system/hyprland.service
```
```
[Unit]
Description=Hyprland Service
After=network.target

[Service]
ExecStart=/path/to/hyprland
Restart=always
RestartSec=3

[Install]
WantedBy=default.target
```
```
sudo systemctl daemon-reload
sudo systemctl enable hyprland.service
sudo systemctl start hyprland.service
sudo systemctl status hyprland.service
```

<br ><br >

## Using Yay for package management
- Search for packages with:
```
yay search_term
```
### Install the packages with:
```
yay -S package_name
```
### Remove packages with:
```
yay -R package_name
```
### To delete a package with its dependencies:
```
yay -Rns package_name
```
### Upgrading (only) the AUR packages:
```
yay -Sua
```
### Removing Yay from your Arch system
```
sudo pacman -Rs yay
```
