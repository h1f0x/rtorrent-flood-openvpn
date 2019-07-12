#!/usr/bin/env bash

# OpenVPN
mkdir -p /config/vpn
if [ ! -f /config/vpn/client.conf ]; then
    cp -r /defaults/config/vpn/client.conf /config/vpn/client.conf
fi

if [ ! -f /config/vpn/vpn.auth ]; then
    cp -r /defaults/config/vpn/vpn.auth /config/vpn/vpn.auth
fi

# rTorrent + FloodUI
rm -rf /config/rtorrent/session/rtorrent.lock

mkdir -p /output/incomplete
mkdir -p /output/complete
mkdir -p /config/rtorrent/session
mkdir -p /config/rtorrent/log
mkdir -p /config/rtorrent/watch
mkdir -p /config/rtorrent/watch/load
mkdir -p /config/rtorrent/watch/start
mkdir -p /config/flood

if [ ! -f /config/rtorrent/rtorrent.rc ]; then
    cp -r /defaults/config/rtorrent/.rtorrent.rc /config/rtorrent/rtorrent.rc
fi

if [ ! -d /config/flood/db ]; then
    cp -r /defaults/config/flood/db /config/flood/db
fi

chmod 775 -R /config
chmod 775 -R /output

chown rtorrent:rtorrent -R /output
chown rtorrent:rtorrent -R /config/rtorrent
chown rtorrent:rtorrent -R /config/flood