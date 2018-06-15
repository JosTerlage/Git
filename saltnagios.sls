saltnagios:
  pkg.installed:
    - pkgs:
      - nagios-nrpe-server
      - nagios-plugins
	 
uncomment line:
  file.uncomment:
    - name: /etc/nagios/nrpe.cfg
    - regex: server_address=*

replace line:
  file.replace:
    - name: /etc/nagios/nrpe.cfg
    - pattern: server_address=
    - repl: server_address=10.0.0.6