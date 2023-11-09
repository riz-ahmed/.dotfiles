# grub bootmanager
# pacman -S grub efibootmgr
# grub-install --efi-directory=/boot --bootloader-id=GRUB
# grub-mkconfig -o /boot/grub/grub.cfg

systemctl start NetworkManager
systemctl enable NetworkManager
pacman -Syu
pacmann -S sudo
sudo pacman -S terminus-font
# Create /etc/vconsole.conf
# adjust the console fonts
# FONT=ter-132b
pacman -S emacs
useradd -m -g users -G wheel,storage,power,video,audio,input riz
# passwd <your username>
# EDITOR=emacs visudo
# %wheel ALL=(ALL) NOPASSWD: ALL    # uncomement this line
su riz
sudo pacman -S xdg-user-dirs
xdg-user-dirs-update
sudo pacman -S git
mkdir aur
cd aur
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
sudo pacman -S pulseaudio
sudo pacman -S alsa-utils alsa-plugins
sudo pacman -S pavucontrol
yay -S pa-applet-git
sudo pacman -S openssh
sudo pacman -S iw wpa_supplicant
sudo pacman -S network-manager-applet
sudo systemctl enable sshd
sudo systemctl enable dhcpcd
sudo pacman -S bluez bluez-utils blueman
sudo systemctl enable bluetooth
sudo systemctl enable fstrim.timer
sudo systemctl enable ntpd
timedatectl set-ntp true
sudo pacman -S xorg-server xorg-apps xorg-xinit xclip xdotool xorg-drivers
sudo pacman -S i3
sudo pacman -S picom
sudo pacman -S ttc-iosevka
sudo pacman -S zsh
chsh -s $(which zsh)
sudo pacman -S alacritty
sudo pacman -S dmenu rofi
sudo pacman -S rofi-emoji rofi-calc
sudo pacman -S sxiv ueberzug
sudo pacman -S firefox mpv
sudo pacman -S zathura zathura-pdf-mupdf
sudo pacman -S tldr fzf tar gzip htop neofetch
sudo pacman -S fd ripgrep bat lsd tree-sitter tree-sitter-cli
sudo pacman -S maim
sudo pacman -S codespell go luarocks ruby rubygems composer php nodejs npm yarn python python-pip jre-openjdk jdk-openjdk julia wget curl
yay -S powershell-bin
sudo pacman -S qrencode
sudo pacman -S zbar
