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

# Start PulseAudio
if [ ! -d /app/.config/pulse ]; then
  sudo -u app mkdir -p /app/.config/pulse
fi

sudo -u app pulseaudio --start --load="module-native-protocol-tcp auth-ip-acl=127.0.0.1 auth-anonymous=1" --exit-idle-time=-1

echo "Starting vncserver use the app user..."
sudo -u app DISPLAY=$DISPLAY USER=root vncserver $DISPLAY -geometry 1280x800 -depth 24 -localhost no

#start xrdp
echo "Starting xrdp service"
sudo service xrdp start 

#sudo xrdp -c /app/.xrdp/xrdp.ini
#sudo xrdp-sesman -c /app/.xrdp/sesman.ini

# keep the container running
# tail -f /app/.vnc/*.log

cd LackeyCCG
sudo -u app wine LackeyCCG &

# TODO: Start noVNC here
/app/noVNC-1.5.0/utils/novnc_proxy --vnc localhost:5901 --listen 0.0.0.0:8080

tail -f /dev/null
