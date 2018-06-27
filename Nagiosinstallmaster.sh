sudo apt-get install -y autoconf gcc libc6 make wget unzip apache2 php libapache2-mod-php7.0 libgd2-xpm-dev
useradd nagios
groupadd nagcmd
usermod -a -G nagcmd nagios
usermod -a -G nagios,nagcmd www-data
cd
sudo wget -q -O nagioscore.tar.gz https://github.com/NagiosEnterprises/nagioscore/archive/nagios-4.3.4.tar.gz
sudo tar -xzf nagioscore.tar.gz
cd nagioscore-nagios-4.3.4/
sudo ./configure --with-httpd-conf=/etc/apache2/sites-enabled
sudo make all
sudo make install
sudo make install-init
sudo update-rc.d nagios defaults
sudo make install-commandmode
sudo make install-config
sudo make install-webconf
sudo a2enmod rewrite
sudo a2enmod cgi
sudo htpasswd -c -b /usr/local/nagios/etc/htpasswd.users nagiosadmin nagiosadmin
sudo systemctl restart apache2
sudo systemctl start nagios
sudo mkdir -p /usr/local/nagios/etc/servers
cd
sudo apt-get install -y -q autoconf gcc libc6 libmcrypt-dev make libssl-dev wget bc gawk dc build-essential snmp libnet-snmp-perl gettext
sudo wget --no-check-certificate -O nagios-plugins.tar.gz https://github.com/nagios-plugins/nagios-plugins/archive/release-2.2.1.tar.gz
sudo tar -xzf nagios-plugins.tar.gz
cd
cd nagios-plugins-release-2.2.1/
sudo ./tools/setup
sudo ./configure
sudo make
sudo make install
sudo systemctl restart nagios
