Voor het installeren van nagios was het idee eerst om een sh bestand te maken dat 
met allemaal bash commando's nagios zou installeren. Het bash bestand zou via saltstack 
uitgerold worden naar de minions en daar worden uitgevoerd. Achteraf bleek een sls bestand
veel makkelijker. Het sh bestand is alsnog toegevoegd, omdat het wel moeite was :P

het bestand saltnagios.sls bevat de code die met het volgende command op alle minions wordt uitgevoerd:

sudo salt '*Minion*' state.apply saltnagios

vervolgens wordt er op de master in het volgende pad een file aangemaakt:

/usr/local/nagios/etc/servers/"monitored_server_host_name".cfg

en in deze file wordt het volgende geplakt:


define host {
        use                             linux-server
        host_name                       "monitored_server_host_name"
        alias                           My client server
        address                         "monitored_server_private_ip"
        max_check_attempts              5
        check_period                    24x7
        notification_interval           30
        notification_period             24x7
}

define service {
        use                             generic-service
        host_name                       "monitored_server_host_name"
        service_description             CPU load
        check_command                   check_nrpe!check_load
}

zie het bestand UBU1604Minion.cfg voor een voorbeeld.

En dan is de Host toegevoegd