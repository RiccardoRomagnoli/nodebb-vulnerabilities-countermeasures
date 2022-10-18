#Flush all chains:
sudo iptables -F INPUT
sudo iptables -F OUTPUT
sudo iptables -F FORWARD

#Set DROP Default policy:
sudo iptables -P INPUT DROP
sudo iptables -P OUTPUT DROP
sudo iptables -P FORWARD DROP

#allowing web traffic on port 4567:
sudo iptables -A INPUT -p tcp --dport 4567 -j ACCEPT
sudo iptables -A OUTPUT -p tcp --sport 4567 -m conntrack --ctstate ESTABLISHED -j ACCEPT

#allowing loopback traffic (for connection to MongoDB):
sudo iptables -I INPUT -i lo -p tcp --sport 27017 -j ACCEPT
sudo iptables -I INPUT -i lo -p tcp --dport 27017 -j ACCEPT
sudo iptables -I OUTPUT -o lo -p tcp --sport 27017 -j ACCEPT
sudo iptables -I OUTPUT -o lo -p tcp --dport 27017 -j ACCEPT

