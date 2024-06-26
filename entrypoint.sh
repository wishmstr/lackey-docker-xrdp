#!/usr/bin/env sh

echo "Starting vncserver..."
vncserver :1 -geometry 1280x800 -depth 24 &

echo "Starting winetricks..."
winetricks vcrun2008
