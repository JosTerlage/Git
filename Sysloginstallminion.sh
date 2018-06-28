sudo apt install syslog-ng -y
sudo cp /etc/syslog-ng/syslog-ng.conf /etc/syslog-ng/syslog-ng.conf.BAK
sudo rm /etc/syslog-ng/syslog-ng.conf
sudo touch /etc/syslog-ng/syslog-ng.conf
echo '@version: 3.5
@include "scl.conf"
@include "`scl-root`/system/tty10.conf"
source s_local { system(); internal(); };
destination d_syslog_tcp {
              syslog(10.0.0.18 transport("tcp") port(514)); };
log { source(s_local);destination(d_syslog_tcp); };
' | sudo tee -a /etc/syslog-ng/syslog-ng.conf
sudo ufw allow 514
sudo ufw reload
sudo systemctl start syslog-ng
sudo systemctl restart syslog-ng
