# Configure and harden SSH daemon:
groupadd ssh-user
usermod -a -G ssh-user pi
# TODO: Update SSH server config
# TODO: Copy SSH public key
systemctl restart ssh.service

# Update the system and install some packages:
apt-get update
apt-get upgrade
apt-get install iptables-persistent
#apt-get install lynis

# Make some basic network configurations:
# TODO: Copy sysctl.conf and iptables rules
