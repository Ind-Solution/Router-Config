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
apt-get install -y iptables-persistent hostapd
apt-get install -y wavemon dnsutils netcat proxychains
apt-get install -y htop screen tmux vim ripgrep icdiff wget curl rsync
#apt-get install -y tcpdump lynis

# Make some basic network configurations:
# TODO: Copy sysctl.conf and iptables rules

# Set up Wi-Fi access point:
# TODO: Update hostapd config
systemctl unmask hostapd.service
systemctl start hostapd.service
systemctl enable hostapd.service

# TODO: Let hostname match vendor prefix of MAC address
