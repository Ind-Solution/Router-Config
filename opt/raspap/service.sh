#!/bin/bash
PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin
NAME=raspapd
DESC="Service control for RaspAP"
DAEMONPATH="/lib/systemd/system/raspapd.service"

WifiDevice="wlan0"

if [ "${action}" = "start" ]; then
    ip link ls up | grep -q "uap0" &> /dev/null
    if [ $? != 0 ]; then
        echo "Adding uap0 interface to ${WifiDevice}..."
        iw dev ${WifiDevice} interface add uap0 type __ap
        ifup uap0
    fi

    echo "RaspAP service start DONE"
    exit 0
elif [ "${action}" = "stop" ]; then
    echo "Stopping network services..."
    #systemctl stop systemd-networkd

    ip link ls up | grep -q "uap0" &> /dev/null
    if [ $? == 0 ]; then
        echo "Removing uap0 interface..."
        ifdown uap0
        iw dev uap0 del
    fi

    echo "RaspAP service stopped. Exiting."
    exit 0
fi

