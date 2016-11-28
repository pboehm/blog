+++
layout = "post"
title = "NIS: Client-Konfiguration"
date = "2012-12-31"

+++

>
> Dieser Artikel wurde von [tuxorials.de](http://tuxorials.de) (Dokuwiki) hierher migriert!
> Mögliche Darstellungsfehler bitte ich zu entschuldigen.
>


In diesem Beispiel soll es nun abschließend um die nötige Konfiguration
gehen, die ein Client benötigt um sich erfolgreich gegenüber einem
NIS-Server zu authentifizieren. Ich beziehe mich dabei auf ein
Ubuntu-System, welches kein komfortables Tool zum Einrichten von NIS
besitzt und deshalb die manuelle Konfiguration erfordert.

Auf dem Client müssen die Pakete `portmap` und `nis` installiert werden,
sowie die NIS-Domäne auf den entsprechenden Wert gesetzt werden. Es ist
dabei der Name zu wählen, der auf Seiten des Servers festgelegt wurde.

```
root@host]# apt-get install portmap nis
```

Außerdem müssen folgende Zeilen an die beschriebenen Dateien angehängt
werden. Die Anzahl der Doppelpunkte richtet sich nach der Anzahl der
Feldern, die in den jeweiligen Dateien vorhanden sind.

*/etc/passwd: (6 x :)*

```
+::::::
```

*/etc/group: (3 x :)*

```
+:::
```

*/etc/shadow: (8 x :)*

```
+::::::::
```

Außerdem muss an die `/etc/yp.conf` folgende Zeile angefügt werden, die
die IP-Adresse des NIS-Server angibt. Alternativ kann dort auch der
Hostname angegeben werden.

```
ypserver 192.168.1.1
```

Damit wäre die Client-Konfiguration abgeschlossen und nach einem Reboot
wäre er dann auch betriebsbereit.
