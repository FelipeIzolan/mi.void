cat << 'EOF'

| mi.void           |
| *wayland + labwc* |

EOF

read -p "- Graphics Driver -"$'\n\n'" 0: Intel"$'\n'" 1: AMD"$'\n\n'" Enter: " driver

if [ $driver -ne "0" -a $driver -ne "1" ]; then
  echo " Invalid: $driver"
  exit
fi

sudo xbps-install linux-firmware-$([[ $driver =  "0" ]] && echo "intel" || echo "amd") msi-dri
sudo xbps-install -y dbus turnstile seatd

sudo xbps-install -y labwc wbg foot fuzzy dejavu-fonts-ttf
sudo xbps-install -y wireplumber pipewire
sudo xbps-install -y wl-clipboard

sudo ln -s /etc/sv/dbus /var/service
sudo ln -s /etc/sv/seatd /var/service
sudo ln -s /etc/sv/turnstiled /var/service

sudo xbps-install -y xdg-user-dirs
xdg-user-dirs-update
sudo xbps-remove -y xdg-user-dirs
 
mkdir -p ~/.cache
mkdir -p ~/.local/share/fonts/

sudo chmod -R 777 ~/.cache

sudo groupadd _seatd
sudo usermod -a -G _seatd $(whoami)

cp -fv ./resources/wallpaper.jpg ~/wallpaper.jpg
cp -fv ./resources/JetBrainsMonoNerdFont-Regular.ttf ~/.local/share/fonts/JetBrainsMonoNerdFont-Regular.ttf
cp -TRfv ./.config ~/.config
