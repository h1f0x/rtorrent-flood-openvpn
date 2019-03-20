#!/usr/bin/env bash

# Restarting Services if dead
systemctl is-active --quiet rtorrent.service || systemctl restart rtorrent.service
systemctl is-active --quiet flood.service || systemctl restart flood.service
systemctl is-active --quiet openvpn-own-client.service || systemctl restart openvpn-own-client.service