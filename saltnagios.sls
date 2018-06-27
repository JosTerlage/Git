nagios:
  pkg.installed:
    - pkgs:
      - nagios-nrpe-server
      - nagios-plugins

uncomment:
  file.uncomment:
    - name: /etc/nagios/nrpe.cfg
    - regex: server_address=*

replace:
  file.replace:
    - name: /etc/nagios/nrpe.cfg
    - pattern: server_address=127.0.0.1
    - repl: server_address=10.0.0.16
