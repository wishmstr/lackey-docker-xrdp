#!/usr/bin/env bash
# set -e

# # disable screensaver and power management
# xset -dpms &
# xset s noblank &
# xset s off &

mkdir -p /app/.vnc

echo "Setting vnc password to $VNC_PASSWORD..."
echo asdfasdf | vncpasswd -f >/app/.vnc/passwd
chmod 600 /app/.vnc/passwd

# echo "Starting xfce4..."
# startxfce4 --replace >/app/.vnc/xfce4.log &

echo "Starting vncserver..."
vncserver :1 -geometry 1280x800 -depth 24 &

# keep the container running
tail -f /dev/null
