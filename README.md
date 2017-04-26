# Firmennetzwerk

## Installierte Pakete

PC1:
  - nmap
  - traceroute

PC2
  - isc-dhcp-server

PC3:
  - bind9

## Verwendete Kommandos

sudo systemctl restart networking.service
sysctl net.ipv4.ip_forward
sudo iptables -t nat -L
sudo iptables -L
sudo ip addr flush enp0s9
for i in 2 3 4 5; do ping -c 3 192.168.109.${i}; done
ssh-keygen -t rsa -f ~/.ssh/id_rsa -N ""
for i in 2 3 4 5; do ssh-copy-id 192.168.109.${i}; done
ssh 192.168.109.3 'sudo apt-get update && sudo apt-get install -y isc-dhcp-server'
ssh 192.168.109.4 'sudo apt-get update && sudo apt-get install -y bind9'
for i in 3 4 5; do ssh 192.168.109.${i} ssh-keygen -t rsa -f ~/.ssh/id_rsa; done

### dhcp
sudo cp dhcpd.conf dhcpd.conf.bak
sudo systemctl restart isc-dhcp-server

#### dhcp-client
sudo dhclient -v enp0s8

### bind9
sudo cp db.empty db.firma09.com
sudo cp db.empty db.109.168.192.in-addr.arpa
sudo systemctl restart bind9
tail /var/log/syslog

dnssec-keygen -a HMAC-MD5 -b 128 -n USER DHCP_UPDATER
scp ddns.key 192.168.109.3:/tmp
sudo chgrp bind ddns.key
sudo chmod 0640 ddns.key
sudo ln -s /etc/bind/db.firma09.com /var/cache/bind/
sudo ln -s /etc/bind/db.109.168.192.in-addr.arpa /var/cache/bind/
sudo chown bind: /var/cache/bind/db.*
dig axfr firma09.com @localhost

### dhcp

sudo cp /tmp/ddns.key /etc/dhcp/
sudo chgrp dhcpd ddns.key
sudo chmod 0640 ddns.key

### resolv.conf
sudo rm /etc/resolv.conf
Händisches Bearbeiten der Datei
