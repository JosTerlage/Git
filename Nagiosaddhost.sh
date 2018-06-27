read -p "What is the monitored server hostname?" hostname
read -p "What is the monitored server private ip?" ipaddress
sudo mkdir /usr/local/nagios/etc/servers/
sudo touch /usr/local/nagios/etc/servers/"$hostname".cfg
echo "define host {
        use                             linux-server
        host_name                       "$hostname"
        alias                           My client server
        address                         "$ipaddress"
        max_check_attempts              5
        check_period                    24x7
        notification_interval           30
        notification_period             24x7
}

define service {
        use                             generic-service
        host_name                       "$hostname"
        service_description             CPU load
        check_command                   check_nrpe!check_load
}
" | sudo tee -a /usr/local/nagios/etc/servers/$hostname.cfg
sudo systemctl restart nagios
