

## Using Yay for package management
### Search for packages with:
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
