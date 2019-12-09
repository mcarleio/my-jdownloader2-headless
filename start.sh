#!/usr/bin/expect -f

# Start OpenVPN
spawn /openvpn.sh
set VPN_SPAWN_ID $spawn_id
expect {
  "Initialization Sequence Completed" {
    # VPN Connection successfull established
    expect_background -i $VPN_SPAWN_ID eof {
      # If OpenVPN looses connection, was stopped or got killed, then kill JD to prevent from IP leaking
      exec killall java
      # exit with no error, so that it restarts
      exit 0
    }
    # Start JD
    spawn /jd.sh
    interact
  }
  "NO_VPN_CONFIGURED" {
    # No OpenVPN configured, start JD
    spawn /jd.sh
    interact
  }
  eof {
    exit 0
  }
}
exit 1