source .zshrc

# guix profile so that all guix installed packages are to found in the path
GUIX_PROFILE="$HOME/.guix-profile"
source "$GUIX_PROFILE/etc/profile"

# Autostart startx at login
if [ -z "${DISPLAY}" ] && [ "${XDG_VTNR}" -eq 1 ]; then
  exec startx
fi
