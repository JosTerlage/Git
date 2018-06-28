sudo apt install syslog-ng -y
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
sudo systemctl restart syslog-ng
