+++
layout = "post"
title = "CUPS: Printer-Sharing"
date = "2012-12-31"

+++

>
> Dieser Artikel wurde von [tuxorials.de](http://tuxorials.de) (Dokuwiki) hierher migriert!
> Mögliche Darstellungsfehler bitte ich zu entschuldigen.
>


Das Drucksystem CUPS (Common Unix Printing System) ist heute der defacto
Standard, um unter unixbasierten Betriebsystemen Drucker zu verwalten
und zu benutzen. Um die Konfiguration allgemein, soll es in diesem
Beitrag nicht gehen, sondern um eine Funktion zum verteilten Zugriff auf
einen Drucker über das Netzwerk.

Um CUPS richtig zu verstehen, muss man wissen, dass CUPS-Server im
Netzwerk untereinander kommunizieren und das CUPS eigentlich nichts
weiter als ein kleiner Webserver ist, welcher zur Konfiguration und zur
Verwaltung der Drucker gebraucht wird. Als Beispiel soll ein kleines
Netzwerk herhalten, welches aus einem zentralen Server und mehreren
Clients besteht. Am Server hängt ein beliebiger Drucker, welcher in CUPS
schon eingerichtet ist. Die Funktion, die aktiviert werden soll, ist
die, dass die Clients ohne explizite Konfiguration eines eigenen
Druckers auf den Drucker am Server zugreifen können. Server: Auf dem
Server muss die Funktion zum Verteilen des lokalen Druckers eingerichet
werden:

```
root@server #] cupsctl --share-printers
```

Dies verfrachtet die lokalen Drucker ins Netwerk, sodass Clients auf sie
zugreifen können. Client: Die Clients müssen so konfiguriert werden,
dass sie global verfügbare Drucker benutzen.

```
root@client #] cupsctl --remote-printers
```

Danach tauchen in den Druck-Dialogen des Client-Systems die global
verfügbaren Drucker auf und können anstandslos benutzt werden.
