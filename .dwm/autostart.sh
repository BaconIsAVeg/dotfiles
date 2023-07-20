#!/usr/bin/env bash

pgrep -x openrgb > /dev/null || openrgb --server &
pgrep -x streamdeck > /dev/null || streamdeck -n &
picom -b &

/usr/bin/dunst &
/usr/bin/dwmblocks &
/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &

if [ -x ~/.fehbg ]; then
  ~/.fehbg
else
  feh --no-fehbg --bg-fill --no-xinerama ${HOME}/.config/wallpaper.jpg
fi

xautolock -locker slock -nowlocker slock -time 30 -secure &
