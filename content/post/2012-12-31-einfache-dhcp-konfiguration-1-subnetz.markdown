+++
layout = "post"
title = "einfache DHCP-Konfiguration (1 Subnetz)"
date = "2012-12-31"

+++

>
> Dieser Artikel wurde von [tuxorials.de](http://tuxorials.de) (Dokuwiki) hierher migriert!
> Mögliche Darstellungsfehler bitte ich zu entschuldigen.
>


Bei einem DHCP-Server (Dynamic Host Configuration Protocol) handelt es
sich um einen Dienst, der anderen PCs im Netzwerk Konfigurationsdaten
wie IP-Adressen und DNS-Server-Adressen dynamisch zuweist. Bei allen
Linux-Distributionen ist der ISC DHCP-Server vorhanden, welcher die
Referenzimplementierung darstellt. Seine Konfiguration für ein einfaches
Subnetz ist Inhalt dieses Beitrages.

Es müssen die Pakete für den DHCP-Server meistens nachinstalliert
werden, wobei die Namen extrem differerieren. Bei Fedora stecken sie im
Paket `dhcp`, bei Ubuntu/Debian im Paket `dhcp3-server`. Es hilft
meistens eine Paketsuche nach `dhcpd`.

Es muss beachtet werden, dass die IP-Adresse des DHCP-Servers selbst
fest vergeben werden muss. Temporär geschieht das mit dem Befehl
`ifconfig`. Wenn dies dauerhaft geschehen soll, muss es in die
speziellen Konfigurationsdateien der Distribution eingetragen werden,
welche eine spezielle Syntax besitzen. Bei Ubuntu/Debian ist dies z.B.
die Datei `/etc/network/intercaes`. Für die nachfolgende Konfiguration
besitzt der DHCP-Server die IP-Adresse `192.168.10.1` und deswegen ist
der DHCP-Server für das Subnetz `192.168.10.0/24` zuständig und wird auf
Broadcast-Anfragen der Clients antworten.

*Nachfolgend ist die Beispiel-Konfiguration aus der Datei
`/etc/dhcp/dhcpd.conf` aufgelistet:*

```
# dhcpd.conf 
# 
# Konfiguration des ISC-DHCP-Server 
# 
option domain-name "DHCP-Server"; 
option domain-name-servers 192.168.10.1;
default-lease-time 180; 
max-lease-time 7200; 
authoritative;  
#
# Subnetz-Deklaration 
subnet 192.168.10.0 netmask 255.255.255.0 { 
  range 192.168.10.10 192.168.10.20;  
  option routers 192.168.10.1; 
}
```

Die Default-Lease-Time ist hier extrem kurz gesetzt, was am Anfang bzw.
beim Aufbau des Netzwerkes zu empfehlen ist. Wenn Sie das so lassen,
belasten Sie ihr Netzwerk unnötig, denn jeder Client wird nach der
Hälfte der Lease-Zeit nachfragen, ob er die selben Daten behalten darf.
D.h. nach 90 Sekunden meldet sich jeder Client beim Server. Beim Aufbau
des Netzwerkes, wo es viele Änderungen geben kann, ist es aber dennoch
sinnvoll.

Die Zeile `subnet 192.168.10.0 netmask 255.255.255.0` legt fest, für
welches Subnetz der DHCP-Server zuständig ist und legt dann nachfolgend
die Range fest, aus welchem der DHCP-Server Adressen verteilt. Die
letzte Zeile legt das Standard-Gateway fest, an welches die Clients
Anfragen schicken, wenn sie an Computer außerhalb des eigenen Netzwerk
Pakete schicken wollen. Dies ist meistens ein Router, hier ist es aber
der DHCP-Server selbst, denn die Konfiguration ist für das zusätzliche
NAT gedacht, was z.B für die Internetweitergabe gebraucht wird.

Wenn Sie die IP-Adresse für den DHCP-Server festgelegt haben, können Sie
den Server nachfolgend starten:

```
root@server #] service dhcpd restart
```

bzw.

```
root@server #] service dhcp3-server restart
```

Wenn das Starten fehlschlägt, kann in den Log-Dateien
(`/var/log/messages` bei Fedora und `/var/log/syslog` bei Ubuntu/Debian)
nach Lösungen gesucht werden. Die häufigsten Fehler sind das Vergessen
eines Semikolons oder die falsche IP-Adresse für den DHCP-Server selbst.

In den vorherigen Log-Dateien kann auch der DHCP-Vergabe-Vorgang
nachverfolgt werden. Wenn der DHCP-Server eine IP-Adresse vergibt, wird
ein Lease in der Datei `/var/lib/dhcpd/dhcpd.leases` angelegt. Leases
sollten dort nicht eigenhändig gelöscht werden, denn der DHCP-Server
löscht ältere Leases, wenn sie benötigt werden. Die Konfiguration ist
somit abgeschlossen und es muss bloß dafür gesorgt werden, dass der
Dienst beim Booten automatisch gestartet wird.
