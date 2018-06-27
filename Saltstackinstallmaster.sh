read -p "What is the master ip address?" ipaddress
curl -L https://bootstrap.saltstack.com -o install_salt.sh
sudo sh install_salt.sh -M -A $ipaddress
sudo systemctl restart salt-minion
sudo salt-key --accept-all
