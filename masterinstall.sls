run install_nagios_server:
  cmd:
    - run
    - name: /home/jos/Git/Nagiosinstallmaster.sh

run install_syslog_server:
  cmd:
    - run
    - name: /home/jos/Git/Sysloginstallmaster.sh

run install_docker:
  cmd:
    - run
    - name: /home/jos/Git/Dockerinstallmaster.sh
