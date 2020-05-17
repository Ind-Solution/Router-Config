# Configure and harden SSH daemon:
groupadd ssh-user
usermod -a -G ssh-user pi
# TODO: Update SSH server config
# TODO: Copy SSH public key
systemctl start ssh.service
systemctl enable ssh.service

# Update the system and install some packages:
apt-get update
apt-get upgrade
apt-get install -y iptables-persistent isc-dhcp-server hostapd
apt-get install -y wavemon dnsutils netcat proxychains
apt-get install -y htop screen tmux vim ripgrep icdiff wget curl rsync
#apt-get install -y tcpdump lynis

# Disable the WPA supplicant service:
systemctl stop wpa_supplicant.service
systemctl disable wpa_supplicant.service

# Make some basic network configurations:
# TODO: Copy sysctl.conf and iptables rules

# Configure and run DHCP server:
# TODO: Update isc-dhcp-server config
systemctl start isc-dhcp-server.service
systemctl enable isc-dhcp-server.service

# Configure and run Wi-Fi access point service:
# TODO: Update hostapd config
systemctl unmask hostapd.service
systemctl start hostapd.service
systemctl enable hostapd.service

#systemctl daemon-reload

# TODO: Let hostname match vendor prefix of MAC address
