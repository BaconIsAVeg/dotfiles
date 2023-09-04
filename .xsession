#!/bin/sh

dex -a -e XFCE

pgrep polkit-gnome > /dev/null || /usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &
pgrep -x nm-applet > /dev/null || nm-applet --indicator &
pgrep -x openrgb > /dev/null || openrgb --server &
pgrep -x streamdeck > /dev/null || streamdeck -n &
pgrep -x picom > /dev/null || picom -b &
pgrep -x dunst > /dev/null || dunst &
pgrep -x mpd > /dev/null || /usr/bin/mpd ${HOME}/.config/mpd/mpd.conf &
pgrep -x xscreensaver > /dev/null || xscreensaver --no-splash &

if [ -x ~/.fehbg ]; then
  ~/.fehbg &
else
  feh --no-fehbg --bg-fill --no-xinerama ${HOME}/.config/wallpaper.jpg &
fi
