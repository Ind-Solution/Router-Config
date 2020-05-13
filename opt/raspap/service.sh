#!/bin/bash
PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin
NAME=raspapd
DESC="Service control for RaspAP"
DAEMONPATH="/lib/systemd/system/raspapd.service"

WifiDevice="wlan0"

if [ "${action}" = "start" ]; then

    ip link ls up | grep -q "uap0" &> /dev/null
    if [ $? != 0 ]; then
        echo "Adding uap0 interface to ${WifiDevice}"
        iw dev ${WifiDevice} interface add uap0 type __ap
        ifconfig uap0 up
        systemctl restart networking.service
    fi

    echo "Starting network services..."
    systemctl start hostapd.service
    sleep 5

    #systemctl start dhcpcd.service
    #sleep 5

    echo "RaspAP service start DONE"
    exit 0
elif [ "${action}" = "stop" ]; then
    echo "Stopping network services..."
    #systemctl stop systemd-networkd
    systemctl stop hostapd.service
    #systemctl stop dhcpcd.service

    ip link ls up | grep -q "uap0" &> /dev/null
    if [ $? == 0 ]; then
        echo "Removing uap0 interface..."
        iw dev uap0 del
    fi

    echo "Services stopped. Exiting."
    exit 0
fi

