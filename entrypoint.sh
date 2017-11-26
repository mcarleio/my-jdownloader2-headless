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

chown -R jdownloader:jdownloader /opt/jd

# Start JDownloader
su -c "java -Djava.awt.headless=true -jar /opt/jd/JDownloader.jar" jdownloader

# Instead of endless sleep loop, just wait endlessly for input
mkfifo keep-running && cat keep-running