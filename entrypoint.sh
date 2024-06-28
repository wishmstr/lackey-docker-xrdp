#!/usr/bin/env sh

echo "Starting vncserver..."
vncserver :1 -geometry 1280x800 -depth 24 & 
startxfce4 &

tail -f /dev/null
#echo "Starting winetricks..."
#winetricks vcrun2008
