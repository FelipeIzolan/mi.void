#!/usr/bin/env bash

sudo xbps-install -S xorg-minimal\
                     xorg-fonts\
                     setxkbmap\
                     xwallpaper\
                     pipewire\
                     wireplumber\
                     dbus\
                     turnstile\
                     rofi\
                     mesa-dri\
		     libX11\
		     libXft\
		     libXinerama\
		     xclip

sudo xbps-install curl\
                  patch\
                  xdg-user-dirs

sudo xbps-install base-devel\
                  libX11-devel\
                  libXft-devel\
                  libXinerama-devel

#####################################################################

dwmp=(
  "https://dwm.suckless.org/patches/cyclelayouts/dwm-cyclelayouts-20180524-6.2.diff"
  "https://dwm.suckless.org/patches/vanitygaps/dwm-cfacts-vanitygaps-6.4_combo.diff"
  "https://dwm.suckless.org/patches/actualfullscreen/dwm-actualfullscreen-20211013-cb3f58a.diff"
  "https://dwm.suckless.org/patches/underlinetags/dwm-underlinetags-6.2.diff"
  "https://dwm.suckless.org/patches/notitle/dwm-notitle-20210715-138b405.diff"
)

stp=(
  "https://st.suckless.org/patches/scrollback/st-scrollback-0.9.2.diff"
  "https://st.suckless.org/patches/scrollback/st-scrollback-mouse-0.9.2.diff"
  "https://st.suckless.org/patches/font2/st-font2-0.8.5.diff"
  "https://st.suckless.org/patches/boxdraw/st-boxdraw_v2-0.8.5.diff"
)

git clone https://git.suckless.org/dwm ./source/dwm
git clone https://git.suckless.org/st ./source/st

for value in ${dwmp[@]}; do
  curl -q ${value} | patch -d ./source/dwm -i -
done

for value in ${stp[@]}; do
  curl -q ${value} | patch -d ./source/st -i -
done

cp -f ./.config/dwm.config.h ./source/dwm/config.h
cp -f ./.config/st.config.h ./source/st/config.h

sudo make clean install -C ./source/dwm
sudo make clean install -C ./source/st

#####################################################################

sudo ln -s /etc/sv/dbus /var/service
sudo ln -s /etc/sv/turnstiled /var/service

#####################################################################

cp -f ./wallpaper.png ~/wallpaper.png
cp -f ./.xinitrc ~/.xinitrc
cp -rf ./.config/rofi ~/.config/rofi

sudo cp -f ./CaskaydiaCoveNerdFont-Regular.ttf /usr/share/fonts

#####################################################################

mkdir ~/.cache
sudo chmod -R 777 ~/.cache
xdg-user-dirs-update

sudo xbps-remove -R curl\
                    patch\
                    xdg-user-dirs\
                    base-devel\
                    libX11-devel\
                    libXft-devel\
                    libXinerama-devel\
                    libXext-devel
