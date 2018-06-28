# Linux eindopdracht

In deze git repo staan alle scripts die nodig zijn voor de linux eindopdracht. In de recycle bin staan oude files/testfiles of files die gebruikt zijn als kladblok.

##Uitleg

De bedoeling is dat eerst Saltstack wordt geinstalleerd op de master en minions. Tijdens het installeren moet de gehele git repo op de server gepulled worden. Verwijder deze clone NIET! Sommige files zijn namelijk nog nodig na de installatie van Saltstack. Daarna kunnen via Saltstack Nagios, Syslog-ng en Docker geinstalleerd worden.

##Voor het installeren

Voor het installeren moeten er een paar gehardcode IP's aangepast worden. Dit omdat het mij niet gelukt is deze als variabelen mee te geven in Saltstack.
De aan te passen ip's zijn in de volgende files te vinden:

-Nagiosinstallminion.sh        line 20 & 21
-Sysloginstallminion.sh        line 10

Op deze 3 plekken dient het IP-adres van de Master ingevoerd te worden.


##Installeren

De beknopte versie van de installatie staat in de "INSTALLATION.txt"
Eerst dient de repo gecloned te worden en worden alle files executable gemaakt met het volgende command:

```git clone https://github.com/JosTerlage/Git.git && cd Git/ && sudo chmod +x Dockerinstallmaster.sh Dockerinstallminion.sh Nagiosaddhost.sh Nagiosinstallmaster.sh Nagiosinstallminion.sh Saltstackinstallmaster.sh Saltstackinstallminion.sh Sysloginstallmaster.sh Sysloginstallminion.sh && cd```
