#!/bin/sh

setSetting() {
	CONFIG_FILE=$1
	JSON_KEY=$2
	JSON_VALUE=$3

	if [ "$JSON_VALUE" ]; then

	    if [ ! -f $CONFIG_FILE ]; then
            echo "{}" > $CONFIG_FILE # create empty json file
        fi

        # override or add specified json key and assign the corresponding value
        jq --arg "VAL" "$JSON_VALUE" "$JSON_KEY="'$VAL' $CONFIG_FILE >/tmp/jd.tmp
        mv /tmp/jd.tmp $CONFIG_FILE
	fi
}

# Save various settings
setSetting /opt/jd/cfg/org.jdownloader.api.myjdownloader.MyJDownloaderSettings.json ".email" "$MY_JD_EMAIL"
setSetting /opt/jd/cfg/org.jdownloader.api.myjdownloader.MyJDownloaderSettings.json ".password" "$MY_JD_PASSWORD"
setSetting /opt/jd/cfg/org.jdownloader.api.myjdownloader.MyJDownloaderSettings.json ".devicename" "$MY_JD_DEVICENAME"
setSetting /opt/jd/cfg/org.jdownloader.settings.GeneralSettings.json ".defaultdownloadfolder" "/home/jdownloader/Downloads"

# Optionally, define custom UID & GID for user jdownloader
if [ -n "${JD_UID}" ]; then
    usermod -u ${JD_UID} jdownloader
fi

if [ -n "${JD_GID}" ]; then
    groupmod -o -g ${JD_GID} jdownloader
    usermod -g ${JD_GID} jdownloader
fi

# Copy sevenzipjbinding1509.jar and sevenzipjbinding1509Linux.jar to libs folder when they are present
if [ -f "/opt/jd/cfg/libs/sevenzipjbinding1509.jar" ] && [ -f "/opt/jd/cfg/libs/sevenzipjbinding1509Linux.jar" ]; then
  mkdir -p /opt/jd/libs/
  cp /opt/jd/cfg/libs/sevenzipjbinding1509.jar /opt/jd/libs/
  cp /opt/jd/cfg/libs/sevenzipjbinding1509Linux.jar /opt/jd/libs/
fi

chown -R jdownloader:jdownloader /opt/jd

# Start JDownloader in endless loop
# -norestart = After update, JD exits and does not automatically restart in background process
while true; do
  if [ `ps -C java -o pid= | wc -l` -eq 0 ]; then
    # if a java process is not already running, start JD
    su -c "`which java` -Djava.awt.headless=true -jar /opt/jd/JDownloader.jar -norestart" jdownloader
  fi
  echo "Waiting..."
  sleep 5
done

