#!/usr/bin/env bash
# set -e

# # disable screensaver and power management
# xset -dpms &
# xset s noblank &
# xset s off &

# Create necessary directories for D-Bus
mkdir -p /var/run/dbus

# Start D-Bus service
dbus-daemon --system --fork

# Create .Xresources file if it does not exist
sudo -u app touch /app/.Xresources

mkdir -p /app/.vnc

echo "Setting vnc password to $VNC_PASSWORD..."
echo $VNC_PASSWORD | vncpasswd -f >/app/.vnc/passwd
chmod 600 /app/.vnc/passwd
chown -R app:app /app/.vnc

# Set DISPLAY environment variable
export DISPLAY=:1

# Create .Xauthority file
sudo -u app touch /app/.Xauthority

# Restart D-Bus service to apply new policy
systemctl restart dbus

echo "Starting vncserver use the app user..."
sudo -u app DISPLAY=$DISPLAY USER=root vncserver $DISPLAY -geometry 1280x800 -depth 24 -localhost no

# keep the container running
# tail -f /app/.vnc/*.log

cd LackeyCCG
sudo -u app wine LackeyCCG

tail -f /dev/null
