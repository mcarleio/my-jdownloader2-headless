# my-jdownloader2-headless
An image for JDownloader 2 in headless mode for use with my.jdownloader.org,
combined with an optional to use OpenVPN client. 

## Running
Replace the example mail, password and volume paths with your corresponding values.

```
docker run \
    -v /your/path/to/config/files:/opt/jd/cfg \
    -v /your/path/to/download/folder:/home/jdownloader/Downloads \
    -e MY_JD_EMAIL='your.mail@example.org' \
    -e MY_JD_PASSWORD='your_password' \
    mcarleio/my-jdownloader2-headless
```

If you want to use VPN, you have to specify at least the path to the OpenVPN config file
and run the container in privileged mode or at least with NET_ADMIN capability: 
```
# Resolves to /opt/jd/cfg/openvpn/my.ovpn
-e VPN_CONFIG_FILE=openvpn/my.ovpn" 

# Run in privileged mode
--privileged 

# ... or run with NET_ADMIN capability
--cap-add NET_ADMIN 
```

## Optional environment variables  
* __MY_JD_DEVICENAME__

  The device name on my.jdownloader.org
  
* __JD_UID__

  The UID the jdownloader user should have
  
* __JD_GID__

  The GID the jdownloader user and group should have 
  
* __VPN_CONFIG_FILE__

  The filepath to the OpenVPN config file (relative to /opt/jd/cfg/)
  
* __VPN_USERNAME__

  If this and **VPN_PASSWORD** is specified, the username and password combination
  is used to authenticate the OpenVPN connection.
  
* __VPN_PASSWORD__

  If this and **VPN_USERNAME** is specified, the username and password combination
  is used to authenticate the OpenVPN connection.
  