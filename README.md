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

### Install [yay.md](https://github.com/osiic/hyprland/blob/main/yay.md)
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
```
 sudo nvim /etc/systemd/logind.conf 
```
```
HandlePowerKey=ignore
HandlePowerKeyLongPress=ignore
HandleLidSwitch=hibernate
PowerKeyIgnoreInhibited=yes
```
```
nvim ~/.config/hypr/hyprland.conf
```
```
bind = , xf86poweroff , exec, wlogout --protocol layar-shell 
```

### auto login (no user and no pass)
```
sudo nvim /etc/systemd/system/getty.target.wants/getty@tty1.service 
```
```
ExecStart=-/sbin/agetty -a {username} - $TERM
```

### Startup Hyprland
```
nvim .zshrc
```
```
if [ -z "$DISPLAY" ] && [ "$XDG_VTNR" = 1 ]; then
  exec /usr/bin/Hyprland
fi
```

### Auto use tmux
```
nvim .zshrc
```
```
if [ "$TMUX" = "" ]; then
 tmux;
fi
```
