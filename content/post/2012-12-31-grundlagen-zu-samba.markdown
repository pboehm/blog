+++
layout = "post"
title = "Grundlagen zu Samba"
date = "2012-12-31"

+++

>
> Dieser Artikel wurde von [tuxorials.de](http://tuxorials.de) (Dokuwiki) hierher migriert!
> Mögliche Darstellungsfehler bitte ich zu entschuldigen.
>


Bevor ich in dieser Rubrik mit einer kleinen Serie zu Samba beginne,
möchte ich einige grundlegende Sachen zu Samba posten, welche zum
grundsätzlichen Verständnis erforderlich sind. Diese Serie wird sich
höchstwarscheinlich in mehrere Szenarien gliedern, welche sich jeweils
um ein Anwendungsbereich handeln werden.

Was ist Samba?
++++++++++++--

Das Open-Source-Projekt Samba hat sich zur Aufgabe gemacht, eine freie
Implementierung eines Servers für das SMB-Protokoll (Server Message
Block) zu schaffen, welches vorwiegend von Microsoft, in Windows, für
Netzwerkfreigaben genutzt wird. Eine Alternative Bezeichnung für das
Protokoll ist CIFS (Common Interface Filesystem), welches eigentlich ein
neues Protokoll darstellt, es denn aber doch nicht ist
;-) . Mit Samba ist es somit
möglich, über Netzwerk, ein Verzeichnis für andere Nutzer
bereitzustellen/freizugeben und somit eine Möglichkeit zum
Dateiaustausch zu schaffen. Mit Hilfe von Samba kann ein Windows-NT4
Server vollständig ersetzt werden, was bedeutet, dass Samba die
Funktionen eines Primary-Domain-Controller (PDC) oder
Backup-Domain-Controller (BDC) einnehmen kann und somit die grundlegende
Funktion eines Windows-Servers ersetzen kann. Ab Version 4 (irgendwann
Mitte 2010) wird Samba in der Lage sein, einen Windows 2000 Server
komplett zu ersetzen, was durch neue Features wie Active Directory
realisiert wird.

Samba ist ebenfalls die Möglichkeit, einen plattformunabhängigen
Datenaustausch zwischen allen typischen Betriebsystemen aufzubauen, was
bedeutet, dass Mac-, Windows-, Unix- und Linuxclients ein gemeinsames
Dateiaustauschprotokoll besitzen. Dieser Austausch wäre zwar auch mit
NFS (Network Filesystem) möglich, aber da Windows noch existiert und es
nativ NFS nicht unterstützt, fällt diese Möglichkeit für den
Dateiaustausch mit dieser Plattform weg. Sollten keine Windows-Clients
vorhanden sein, kann der Dateiaustausch auch komplett ohne Samba und mit
NFS geschehen. NFS widmet sich in Zukunft eine eigene Kategorie im
Bereich der Server-Konfiguration.

Samba kann aber auch ganz triviale Aufgaben wie File-Sharing mit
Freunden oder Zugreifen auf Windows-Freigaben bereitstellen, was Samba
zu meinem Lieblings-Server macht.  

Starten und Stoppen von Samba
+++++++++++++++++++++++++++--

Grundsätzlich ist der Samba-Server in zwei Server-Prozesse gesplittet:
smbd und nmbd, welche normalerweise auch jeweils ihr eigenes Init-Script
haben und so nacheinander gestartet werden. Manche Distributionen haben
smbd und nmbd zu einem Script zusammenfasst, sodass nur ein Script
angeschubst werden muss, dieses Script heißt meistens samba.

Um Samba manuell zu starten, geben Sie folgenden Befehl ein, wobei
vorrausgesetzt wird, dass Sie root-Rechte haben:

```
root@host ]# /etc/init.d/smbd start root@host ]# /etc/init.d/nmbd start
```

oder

```
root@host ]# /etc/init.d/samba start
```

*Alternativen:* Es besteht die Möglichkeit, sich den Weg über
`/etc/init.d` zu sparen und stattdessen das Programm `service` zu
nutzen, welches eigentlich nur die obigen Befehle verkürzt. Eventuell
muss `service` als Paket nachinstalliert werden.

```
root@host ]# service smbd start
```

openSUSE geht in der Beziehung einen eigenen Weg, indem Sie allen
Init-Scripten einen Alias zuweist, sodass man Samba auch wie folgt
starten kann:

```
root@suse ]# rcsamba start
```

Die grundlegenden Befehle, die ein Init-Script versteht sind: start,
stop, restart und status

Wie konfiguriert man Samba?
+++++++++++++++++++++++++++

Die komplette Konfiguration von Samba geschieht in der Datei `smb.conf`,
welche sich normalerweise in `/etc/samba/` befindet. Diese Datei ist
normalerweise schon gut gefüllt und gut kommentiert. Die Kommentare
beginnen entweder mit einem \# oder einem Semikolon. Um eine Funktion zu
aktivieren, muss normalerweise bloß das führende Kommentarzeichen
entfernt werden.

Diese Datei ist in mehrere Sections unterteilt, wobei man zwischen
folgenden unterscheidet: (Liste nicht vollständig)

-   `[global]` - In dieser Section werden die globalen Einstellungen,
    wie Server-Name oder Arbeitsgruppe festgelegt, aber auch, was für
    eine Funktion Samba ausführen und welche Rolle Samba im Netzwerk
    spielen soll.
-   `[printers]` - Da es mit Samba auch möglich ist, Drucker für Clients
    im Netzwerk bereitzustellen, wird das in dieser Section
    administriert.
-   `[homes]` und `[netlogon]` - Die zentrale Funktion eines
    Windows-Servers ist ja die Bereitstellung von Benutzerverzeichnissen
    im Netzwerk, sodass ein Nutzer sich von jedem Rechner aus, mit
    seinem Account anmelden kann, dieser Funktion wird dehalb einer
    extra Section zugeteilt.

Und für jede eigene Freigabe wird ebenfalls eine eigene Section
angelegt, sodass eine Freigabe des Musikverzeichnisses eine Section
`[Musik]` nach sich ziehen würde.

Welche Konfigurationsmöglichkeiten gibt es?
++++++++++++++++++++++++++++++++++++++++++-

Die Optionen zur Konfiguration werden in die Sections eingeordnet, wobei
es durch die lange Entwicklungsgeschichte zahlreiche Überschneidungen in
der Funktion von Optionen gibt.

Eine Option sieht folgend aus:

```
optionname = argument
```

z.B

```
server string = Fedora 11 - Samba Server
```

Für jede Option wird eine eigene Zeile genommen und sie muss nicht mit
einem Semikolon oder einem anderen Zeichen abgeschlosssen werden.

*Wichtigste Optionen nach Sections unterteilt:*

**[global]**

 Direktive       | mögliche Werte                     | Beschreibungen
 +++++++++++++++ | +++++++++++++++++++++++++++++++++- | ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 workgroup       | WORKGROUP, ARBEITSGRUPPE           | Hier wird festgelegt für welche Arbeitsgruppe der Server zuständig ist
 server string   | Server-Name                        | Der Name des Servers, unter welchem er erreichbar sein wird
 log file        | /var/log/samba/log.%m              | Jeder beliebige Pfad, wo Samba seine Logs schreiben soll
 max log size    | 50                                 | Maximale Größe der Log-Datei in KiloBytes, hier z.B 50KB
 os level        | 64                                 | Gibt die Rangfolge innerhalb eines Windows-Netzwerks an; PDC sollte den großten Wert haben; 64 ist ein Wert den ein normaler Windows-Server nie erreichen wird
 security        | share, user, domain, ads, server   | Gibt die Sicherheitsmethode an, welcher vom Samba-Server verwendet werden soll (Modis werden in den jeweiligen Szenarios erklärt)
 map to guest    | bad user, jeglicher Benutzername   | Gibt an, welche Benutzer zu einem Gast-Account gemappt werden
 guest account   | nobody, jeglicher Benutzername     | Gibt das Gast-Benutzerkonto an unter welchem der Gast-Benutzer auf die Freigaben zugreift
 guest ok        | yes / no                           | Gibt an, ob grundsätzlich, der Zugriff durch einen Gast erlaubt ist

**[Alle Freigaben]**

 Direktive    | mögliche Werte           | Beschreibungen
 ++++++++++++ | ++++++++++++++++++++++++ | +++++++++++++++++++++++++++++++++++++++++++++++++++++++++--
 path         | /path/to/share           | Jeder Pfad der von Ihnen freigegeben werden soll
 comment      | Dies ist eine Freigabe   | Dies ist eine Beschreibung für die Freigabe
 browseable   | yes / no                 | Gibt an, ob die Freigabe vom Nutzer „betreten“ werden darf
 read only    | yes / no                 | Erlaubt entweder schreibenden oder lesenden Zugriff
 writeable    | yes / no                 |
 guest only   | yes / no                 | Gibt an, ob der Zugriff auf Gäste beschränkt ist

Für weitere Informationen, durchsuchen Sie die weiteren Szenarien oder Sie
konsultieren die Manpage mit `man smb.conf`
