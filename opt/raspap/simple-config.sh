ACTION="start"
PUBLIC_INTERFACE="eth0"
PRIVATE_INTERFACE="wlan0"

if [ "${ACTION}" = "start" ]; then
    iptables -t nat -A POSTROUTING -o ${PUBLIC_INTERFACE} -j MASQUERADE
    iptables -A FORWARD -i ${PUBLIC_INTERFACE} -o ${PRIVATE_INTERFACE} -m conntrack --ctstate RELATED,ESTABLISHED -j ACCEPT
    iptables -A FORWARD -i ${PRIVATE_INTERFACE} -o ${PUBLIC_INTERFACE} -j ACCEPT

    systemctl start isc-dhcp-server.service
    systemctl start hostapd.service
elif [ "${ACTION}" = "stop" ]; then
    systemctl stop hostapd.service
    systemctl stop isc-dhcp-server.service

    iptables -D FORWARD -i ${PRIVATE_INTERFACE} -o ${PUBLIC_INTERFACE} -j ACCEPT
    iptables -D FORWARD -i ${PUBLIC_INTERFACE} -o ${PRIVATE_INTERFACE} -m conntrack --ctstate RELATED,ESTABLISHED -j ACCEPT
    iptables -t nat -D POSTROUTING -o ${PUBLIC_INTERFACE} -j MASQUERADE
fi
