+++
layout = "post"
title = "Grundlegende Squid-Konfiguration"
date = "2012-12-31"

+++

>
> Dieser Artikel wurde von [tuxorials.de](http://tuxorials.de) (Dokuwiki) hierher migriert!
> Mögliche Darstellungsfehler bitte ich zu entschuldigen.
>


Beim Squid handelt es sich um einen sogenannten Proxy-Server, welcher
einmal zum Beschränken des Internetverkehrs aber auch zum
Zwischenspeichern statischer Inhalte eingesetzt werden kann. Die
grundlegende Konfiguration des Proxies beschreibt der folgende Artikel.

Normalerweise muss das Paket nachinstalliert werden, welches mit
folgendem Befehl durchgeführt wird:

```
root@server #] apt-get install squid
```

Dabei wird auch eine sehr sehr umfangreiche Konfigurationsdatei mit
installiert, wobei auf eine Direktive gefühlt 100 Zeilen Kommentare
kommen. Dies macht die Konfiguration einfacher aber auch etwas
unübersichtlich, weshalb hier nur das nötigste dargestellt wird.

Die Konfigurationsdatei befindet sich unter `/etc/squid/squid.conf` und
muss folgende wichtige Direktive enthalten:

```
http_port 3128
```

Dies legt fest, dass Squid auf dem Port 3128 lauscht, was wichtig ist,
weil es auf den Clients eingetragen werden muss. Üblich ist, dass ein
Proxy auf dem Port 8080 lauscht, weshalb das wenn nötig angepasst werden
kann. Die weiteren Direktiven besitzen sinnvolle Standardwerte und
werden deswegen hier nicht dargestellt.

ACLs
+++-

Die ganze Funktionsvielfalt erreicht man mit Hilfe der sogenannten
Access Control Lists (ACL), welche bestimmen, was eine bestimmte Gruppe
von Hosts tun oder auch nicht tun darf.

```
acl workplaces src 192.168.1.151-192.168.1.250 
acl administration src 192.168.1.0-192.168.1.150
```

Mit der vorherigen ACL werden zwei IP-Adressbereiche festgelegt. Einmal
den Bereich `workplaces`, welcher die Rechner beinhaltet deren
Verbindung zum Internet eingeschränkt werden soll und den Bereich
`administration`, welcher alle Rechner des Subnetz enthält die freien
Zugriff auf das Internet erhalten sollen.

```
acl news dstdomain .spiegel.de .zeit.de .faz.net 
acl suche dstdomain .google.de .bing.de .yahoo.de
```

Jetzt werden die Domains festgelegt, welche nachher der Gruppe
`workplaces` erlaubt werden. Es können mehrere Domains aufgeführt
werden, wobei der führende Punkt mit eingetragen werden sollte, da sonst
keine Subdomains erlaubt sind.

```
http_access allow administration 
http_access allow workplaces news 
http_access allow workplaces suche  
# And finally deny all other access to this proxy
http_access deny all
```

Hier wird nun entgültig der Internetzugriff geregelt. Der Gruppe
`administration` wird der Zugriff komplett erlaubt und die
Gruppe workplaces darf nur Seiten betreten, die den ACLs `news` und
`suche` entsprechen. Abschließend wird der Zugriff für alle Hosts, die
keiner ACL entsprechen, gesperrt.

Abschließend kann der Proxy mit folgendem Befehl gestartet werden:

```
root@server #] /etc/init.d/squid start
```

Eine Möglichkeit Squid dazu zu bewegen, seine Konfiguration neu
einzulesen ohne ihn dabei neuzustarten, ist der Befehl:

```
root@server #] /etc/init.d/squid reload
```
