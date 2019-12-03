#!/bin/bash

shopt -s nullglob
OVPN_FILES=(/opt/jd/cfg/ovpn/*.ovpn)

# check if at least one ovpn configuration is present, else exit
if [ "${#OVPN_FILES[@]}" -eq "0" ]; then
  echo "NO_VPN_CONFIGURED"
  exit;
fi

# Use random ovpn configuration
VPN_CONFIG_FILE=${OVPN_FILES[$RANDOM % ${#OVPN_FILES[@]}]}

# Configure device node for OpenVPN
if [ ! -e "/dev/net/tun" ]; then
  mkdir -p /dev/net
  mknod /dev/net/tun c 10 200
fi
chmod 600 /dev/net/tun

# Start OpenVPN
if [ -z "$VPN_USERNAME" -o -z "$VPN_PASSWORD" ]; then
  su -c "openvpn --config '$VPN_CONFIG_FILE'"
else
  su -c "openvpn --config '$VPN_CONFIG_FILE' --auth-user-pass <(echo -e '$VPN_USERNAME\n$VPN_PASSWORD')"
fi

echo "OpenVPN stopped"
