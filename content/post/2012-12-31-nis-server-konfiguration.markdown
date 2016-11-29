+++

tags = ["tuxorials", "german"]
layout = "post"
title = "NIS: Server-Konfiguration"
date = "2012-12-31"

+++

>
> Dieser Artikel wurde von [tuxorials.de](http://tuxorials.de) (Dokuwiki) hierher migriert!
> Mögliche Darstellungsfehler bitte ich zu entschuldigen.
>


In diesem Atikel geht es um die Konfiguration des NIS (Network
Information System), welches für eine zentrale Authentifizierung der
Nutzer eingesetzt werden kann. NIS ist dabei ein Produkt von SUN
Microsystems und hieß ehemals „Yellow Pages“, was dann aber aus
lizenzrechtlichen Gründen in NIS geändert werden musste. Aus diesem
Grund tragen die jeweiligen NIS-Programme auch immer noch ein „yp“ in
ihren Namen.

Um eine komplette Benutzerauthentifizierung zu ermöglichen, ist die
Freigabe von /home über NFS erforderlich, sodass die Clients dieses
Freigabe beim Booten einbinden und die Benutzer somit auf ihre
Homeverzeichnisse zugreifen können.

Ich beziehe mich in diesem Artikel auf ein Ubuntu-System, jedoch sollte
sich die Konfiguration bei anderen Distributionen nicht erheblich
unterscheiden.

Es ist erforderlich, die folgenden Pakete zu installieren. Dies
geschieht mit dem Befehl:

```
root@ubuntu-server]# apt-get install portmap nis
```

Es muss sichergestellt werden, dass in der Datei `/etc/hosts.allow` die
folgende Zeile enthalten ist:

```
portmap ypserv ypbind rpc.mountd : ALL
```

Bei der Installation wird nach einem NIS-Domainnamen gefragt, welche
entsprechend gewählt werden sollte. Ich werde hier die Domain TUXORIALS
verwenden, da die folgende Konfiguration darauf aufbaut.

Danach muss sichergestellt werde, dass folgende Zeile in der
`/etc/default/portmap` auskommentiert ist:

```
OPTIONS="-i 127.0.0.1"
```

Es ist ebenfalls erforderlich, die Funktion des Dienstes zu bestimmen
(Master, Client oder Slave). Für den Server ist die Variante Master zu
wählen und deshalb ist der Wert der Direktive in der Datei
`/etc/default/nis` wie folgt zu ändern:

```
# Are we a NIS server and if so what kind (values: false, slave, master)?
# NISSERVER=master
```

Nachfolgend muss dem NIS-Server noch einmal mitgeteilt werden, dass er
auch wirklich der Server ist, indem die Datei `/etc/yp.conf` um folgende
Zeile erweitert wird. Dabei sollte die Zeile die einzige dieser Art
sein.

```
domain TUXORIALS server ubuntu-server
```

Nachfolgend kann das Makefile für die Erstellung der NIS-Maps bearbeitet
werden. Es befindet sich unter `/var/yp/Makefile` und es legt einige
Einstellungen, wie die Mindest-UID der Nutzer, fest. Da die Datei sehr
groß und kompliziert ist, sollte es ausreichen das Makefile ohne
Änderungen zu übernehmen.

Da NIS allgemein als sehr unsicher gilt, muss nun der Zugriff auf den
Server etwas eingeschränkt werden, welches durch die Bearbeitung der
Datei `/etc/ypserv.securenets` geschieht. Die Zeile, die wir hinzufügen
müssen, sieht wie folgt aus:

```
# Eigenes Netz 255.255.255.0                 
192.168.1.0
```

Hiermit dürfen nur Clients aus dem Netz 192.168.1.0 auf den NIS-Server
zugreifen und sich auch gegebenenfalls authentifizieren. Dies sollten
Sie entsprechend Ihres Netzwerkes anpassen.

Nun erfolgt das erste Bauen der NIS-Maps mit dem nachfolgenden Befehl.
Es werden dafür alle benötigten Dateien erstellt, was man auch aus den
Befehlsausgaben entnehmen kann. Aus diesem Grund kann es auch zu
Fehlermeldungen kommen, die aber getrost ignoriert werden können, außer
es sind irgendwelche Syntaxfehler, die ausgegeben werden.

```
root@ubuntu-server #] ypinit -m
```

Abschließend müssen die Dienste neugestartet werden, was mit folgenden
Befehlen geschieht:

```
root@ubuntu-server #] /etc/init.d/portmap restart 
root@ubuntu-server #] /etc/init.d/nis restart
```

*ACHTUNG:* Bei jeglicher Änderung an den Nutzerdaten (neuer Nutzer,
Passwortänderung) muss folgender Befehl ausgeführt werden. Natürlich
bietet sich hier eine Automatisierung mit Hilfe von cron an.

```
root@ubuntu-server #] make -C /var/yp/
```

Die Konfiguration auf Seite des Clients wurde in einen eigenen Artikel
ausgelagert.
