# Linux eindopdracht

In deze git repo staan alle scripts die nodig zijn voor de linux eindopdracht. In de recycle bin staan oude files/testfiles of files die gebruikt zijn als kladblok.

## Uitleg

De bedoeling is dat eerst Saltstack wordt geinstalleerd op de master en minions. Tijdens het installeren moet de gehele git repo op de server gepulled worden. Verwijder deze clone NIET! Sommige files zijn namelijk nog nodig na de installatie van Saltstack. Daarna kunnen via Saltstack Nagios, Syslog-ng en Docker geinstalleerd worden.

## Voor het installeren

Voor het installeren moeten er een paar gehardcode IP's aangepast worden. Dit omdat het mij niet gelukt is deze als variabelen mee te geven in Saltstack.
De aan te passen ip's zijn in de volgende files te vinden:

-Nagiosinstallminion.sh        line 20 & 21
-Sysloginstallminion.sh        line 10

Op deze 3 plekken dient het IP-adres van de Master ingevoerd te worden.


## Installeren

De beknopte versie van de installatie staat in de "INSTALLATION.txt"

Eerst dient de repo gecloned te worden op alle machines en worden alle files executable gemaakt met het volgende command:

```
git clone https://github.com/JosTerlage/Git.git && cd Git/ && sudo chmod +x Dockerinstallmaster.sh Dockerinstallminion.sh Nagiosaddhost.sh Nagiosinstallmaster.sh Nagiosinstallminion.sh Saltstackinstallmaster.sh Saltstackinstallminion.sh Sysloginstallmaster.sh Sysloginstallminion.sh && cd
```

Vervolgens kan Saltstack geinstalleerd worden met de volgende commands:

Op de Master:

```
./Git/Saltstackinstallmaster.sh
```

Op de Minion:

```
./Git/Saltstackinstallminion.sh
```

Daarna kunnen alle keys op de Master geaccepteerd worden met:

```
sudo salt-key --accept-all
```

Hierna worden op de Master de sls files naar hun folder verplaatst met het volgende command:

```
sudo mkdir /srv/salt && sudo mv Git/masterinstall.sls /srv/salt && sudo mv Git/minioninstall.sls /srv/salt
```

Om Nagios, Syslog-ng en Docker te installeren op de master wordt op de master het volgende commmand uitgevoerd:

```
sudo salt '*Master*' state.apply -t 10000 masterinstall
```

Om Nagios, Syslog-ng en Docker te installeren op de minion wordt op de master het volgende commmand uitgevoerd:

```
sudo salt '*Minion*' state.apply -t 10000 minioninstall
```

Als laatste moet de Minion voor Nagios ook toegevoegd worden. Dit wordt gedaan door op de Master het volgende command uit te voeren:

```
./Git/Nagiosaddhost.sh
```


## Bronnen

Voor het maken van al deze scripts zijn verschillende bronnen gebruikt. Al deze bronnen zijn door elkaar heen gebruikt om tot 1 werkende repo te komen. De volgende bronnen zijn gebruikt:

* [Saltstack installation](https://docs.saltstack.com/en/2017.7/topics/tutorials/salt_bootstrap.html)
* [README.md Template](https://gist.github.com/PurpleBooth/109311bb0361f32d87a2)
* [HowToForge Nagios](https://www.howtoforge.com/tutorial/ubuntu-nagios/)
* [DigitalOcean Nagios](https://www.digitalocean.com/community/tutorials/how-to-install-nagios-4-and-monitor-your-servers-on-ubuntu-16-04)
* [TecMint Nagios](https://www.tecmint.com/install-nagios-core-in-ubuntu-and-debian/)
* [WeberNetz Syslog](https://blog.webernetz.net/basic-syslog-ng-installation/)
* [HowToForge Docker](https://www.howtoforge.com/tutorial/ubuntu-docker/)
