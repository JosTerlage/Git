read -p "What is the master ip address?" ipaddress
curl -L https://bootstrap.saltstack.com -o install_salt.sh
sudo sh install_salt.sh -M -A $ipaddress
sudo systemctl restart salt-minion
sudo salt-key --accept-all
sudo apt install syslog-ng
sudo cp /etc/syslog-ng/syslog-ng.conf /etc/syslog-ng/syslog-ng.conf.BAK
sudo rm /etc/syslog-ng/syslog-ng.conf
sudo touch /etc/syslog-ng/syslog-ng.conf
echo '@version: 3.5
@include "scl.conf"
@include "`scl-root`/system/tty10.conf"
    options {
        time-reap(30);
        mark-freq(10);
        keep-hostname(yes);
        };
    source s_local { system(); internal(); };
    source s_network {
        syslog(transport(tcp) port(514));
        };
    destination d_local {
    file("/var/log/syslog-ng/messages_${HOST}"); };
    destination d_logs {
        file(
            "/var/log/syslog-ng/logs.txt"
            owner("root")
            group("root")
            perm(0777)
            ); };
    log { source(s_local); source(s_network); destination(d_logs); };
' | sudo tee -a /etc/syslog-ng/syslog-ng.conf
sudo ufw allow 514
sudo ufw reload
sudo mkdir /var/log/syslog-ng
sudo touch /var/log/syslog-ng/logs.txt
sudo chmod 777 /var/log/syslog-ng/logs.txt
sudo systemctl start syslog-ng
sudo dpkg -l selinux*
sudo apt-get update
sudo apt-get install -y autoconf gcc libc6 make wget unzip apache2 php libapache2-mod-php7.0 libgd2-xpm-dev
cd /tmp
wget -O nagioscore.tar.gz https://github.com/NagiosEnterprises/nagioscore/archive/nagios-4.3.4.tar.gz
tar xzf nagioscore.tar.gz
cd /tmp/nagioscore-nagios-4.3.4/
sudo ./configure --with-httpd-conf=/etc/apache2/sites-enabled
sudo make all
sudo useradd nagios
sudo usermod -a -G nagios www-data
sudo make install
sudo make install-init
sudo update-rc.d nagios defaults
sudo make install-commandmode
sudo make install-config
sudo make install-webconf
sudo a2enmod rewrite
sudo a2enmod cgi
sudo ufw allow Apache
sudo ufw reload
sudo htpasswd -c /usr/local/nagios/etc/htpasswd.users nagiosadmin
sudo systemctl restart apache2.service
sudo systemctl start nagios.service
sudo apt-get install -y autoconf gcc libc6 libmcrypt-dev make libssl-dev wget bc gawk dc build-essential snmp libnet-snmp-perl gettext
cd /tmp
wget --no-check-certificate -O nagios-plugins.tar.gz https://github.com/nagios-plugins/nagios-plugins/archive/release-2.2.1.tar.gz
tar zxf nagios-plugins.tar.gz
cd /tmp/nagios-plugins-release-2.2.1/
sudo ./tools/setup
sudo ./configure
sudo make
sudo make install
sudo systemctl restart nagios.service
cd
