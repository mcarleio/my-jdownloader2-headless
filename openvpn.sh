#!/bin/sh

if [ ! -f "/opt/jd/cfg/$VPN_CONFIG_FILE" ]; then
  echo "NO_VPN_CONFIGURED"
  exit;
fi

# Configure device node for OpenVPN
if [ ! -e "/dev/net/tun" ]; then
  mkdir -p /dev/net
  mknod /dev/net/tun c 10 200
fi
chmod 600 /dev/net/tun

# Start OpenVPN
if [ -z "$VPN_USERNAME" -o -z "$VPN_PASSWORD" ]; then
  su -c "openvpn --config '/opt/jd/cfg/$VPN_CONFIG_FILE'"
else
  su -c "openvpn --config '/opt/jd/cfg/$VPN_CONFIG_FILE' --auth-user-pass <(echo -e '$VPN_USERNAME\n$VPN_PASSWORD')"
fi

echo "OpenVPN stopped"
