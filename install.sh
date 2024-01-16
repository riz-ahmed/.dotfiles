# grub bootmanager
# pacman -S grub efibootmgr
# grub-install --efi-directory=/boot --bootloader-id=GRUB
# grub-mkconfig -o /boot/grub/grub.cfg

systemctl start NetworkManager
systemctl enable NetworkManager
pacman -Syu
pacmann -S sudo
sudo pacman -S terminus-font
# touch /etc/vconsole.conf
# adjust the console fonts
# FONT=ter-132b
pacman -Sy emacs
useradd -m -g users -G wheel,storage,power,video,audio,input riz
# passwd <your username>
# EDITOR=emacs visudo
# %wheel ALL=(ALL) NOPASSWD: ALL    # uncomement this line
su riz
sudo pacman -Sy xdg-user-dirs git pulseaudio xdg-user-dirs-update pulseaudio pavucontrol openssh iw wpa_supplicant network-manager-applet bluez bluez-utils blueman xorg-server xorg-apps xorg-xinit xclip xdotool xorg-drivers i3 picom ttc-iosevka zsh alacritty dmenu rofi rofi-emoji rofi-calc sxiv ueberzug firefox mpv firefox mpv zathura zathura-pdf-mupdf tldr fzf tar gzip htop neofetch fd ripgrep bat lsd tree-sitter tree-sitter-cli maim codespell go luarocks ruby rubygems composer php nodejs npm yarn python python-pip jre-openjdk jdk-openjdk julia wget curl qrencode zbar texlive-core texlive-latexextra latexmk texlive-bibtexextra texlive-fontsextra texlive-science texlive-publishers gnupg pass
cd ~/Downloads
mkdir aur
cd aur
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
yay -S pa-applet-git git-remote-gcrypt
sudo systemctl enable sshd
sudo systemctl enable dhcpcd
sudo systemctl enable bluetooth
sudo systemctl enable fstrim.timer
sudo systemctl enable ntpd
timedatectl set-ntp true
chsh -s $(which zsh)
yay -S powershell-bin
sudo pacman -Syu qutebrowser
yay -S pass-update
