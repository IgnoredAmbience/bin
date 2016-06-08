#!/bin/sh
mac=${RANDOM:0:2}:${RANDOM:0:2}:${RANDOM:0:2}:${RANDOM:0:2}:${RANDOM:0:2}:${RANDOM:0:2}
sudo nmcli connection down VirginTrainsEC-WiFi
sudo nmcli connection modify VirginTrainsEC-WiFi 802-11-wireless.cloned-mac-address $mac
sudo rm -f /var/lib/NetworkManager/*.lease
sleep 1
sudo nmcli connection up VirginTrainsEC-WiFi
firefox --private-window http://example.com
