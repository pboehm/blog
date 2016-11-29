+++

tags = ["tuxorials", "german"]
layout = "post"
title = "deb-Paket bauen"
date = "2012-12-31"
+++

>
> Dieser Artikel wurde von [tuxorials.de](http://tuxorials.de) (Dokuwiki) hierher migriert!
> Mögliche Darstellungsfehler bitte ich zu entschuldigen.
>


In diesem Beitrag geht es um den Bau eines Debian-Paketes (.deb),
welches in Distributionen wie Debian und darauf basierenden Distros, für
die Verteilung und Aktualisierung von Software eingesetzt wird. Den
Vorgang des Bauens und Erstellens beschreibt folgender Artikel.

Szenario Ich möchte zur Darstellung des Vorgangs, das Verpacken eines
Update-Scripts beschreiben. Es heißt `upd_client.sh` und soll nach
`/etc/init.d` verschoben und in den Bootprozess integriert werden.

Grundlegende Infos
++++++++++++++++++

Eine Debian-Paketdatei besteht einmal aus einem `ar`-Archiv, das
wiederum mit gzip, bzip2 oder LZMA komprimierte tar-Archive enthält.
Diese enthalten die eigentlichen Programmdateien sowie Metainformationen
wie Versionsinformationen des enthaltenen Programms und Abhängigkeiten
zu weiteren Paketen, welches dieses Programm zum laufen benötigt oder
die Funktion verbessern.

*Jedes Binärpaket besteht aus drei Dateien:*

-   `debian-binary` eine Textdatei mit der Versionsnummer des
    verwendeten Paketformats
-   `control.tar.gz` ein mit `tar` und `gzip` gepacktes Archiv, enthält
    Dateien, die zur Installation dienen oder Abhängigkeiten auflisten.
-   `data.tar.gz` oder alternativ data.tar.bz2 enthält die eigentlichen
    Programmdaten mit relativen Pfaden.

Grundstruktur zum Bauen eines deb-Pakets
+++++++++++++++++++++++++++++++++++++++-

Um ein Debian-Paket zu bauen, muss eine ganz bestimmte Hierarchie an
Ordnern und Dateien vorhanden sein, welche folgend aufgelistet ist.

```
/home/philipp/updatepackage/
|-- DEBIAN
|   |-- control
|   |-- postinst
|   |-- preinst
|   `-- prerm
 `-- etc  
 `   `-- init.d  
 `       `-- upd_client.sh
```

Es muss unbedingt der `DEBIAN`-Ordner vorhanden sein, welcher unbedingt
die `control` Datei und optionalen Scripte wie `postinst`, `preinst`,
`prerm` enthalten muss. Auf gleicher Ebene wie der DEBIAN-Ordner können
dann die Verzeichnisse erstellt werden, wohin die enthaltenen Dateien
bei der Installation kopiert werden.

So wird hier die Struktur von `/etc/init.d` erstellt, in welche dann
auch das `upd_client.sh` hineingelegt wird.

essentielle Dateien
++++++++++++++++++-

Die optionalen Scripte im DEBIAN-Ordner werden, wie der Name schon
vermuten lässt, an bestimmten Zeitpunkten ausgeführt. Es muss beachtet
werden, dass es sich jeweils um Bourne-Shell-Scripte handelt, die also
nicht von der Standardshell `bash` interpretiert werden. `postinst` wird
dabei nach dem Kopieren der Dateien, `preinst` vor dem Kopieren und
`prerm` vor dem Entfernen des Paketes ausgeführt.

*Nachfolgend ist ein Beispiel für eine DEBIAN/control Datei abgebildet:*

```
Package: updatepackage
Version: 0.0.13
Section: admin
Priority: optional
Architecture: all
Essential: no
Depends: zsh
Installed-Size: 10KB
Maintainer: Philipp Böhm
Description: Paket, welches die Clients automatisiert beim Start aktualisiert
```

Es werden hier z.B der Name des Paketes, die Versionsnummer aber auch
Abhängigkeiten festgelegt, wobei Abhängigkeiten immer als Paketnamen
beschrieben werden.

*Nachfolgend ist ein Beispiel für ein DEBIAN/postinst-Script
aufgelistet:*

```
#!/bin/sh
#
# Script, welches nach dem Kopieren/Installieren der  
# eigentlichen Daten ausgeführt wird, um Konfigurationen  
# durchzuführen. Es ist aber auch der Ort um jegliche  
# Befehle zur Konfiguration der Clients durchzuführen.
#
set -e  

if [ "$1" = "configure" ]  then
  ####  # Start-Script in den Autostart einfügen  ####  
  if [ -e /etc/init.d/upd_client.sh ]  
  then  
    /usr/sbin/update-rc.d upd_client.sh start 40 2 3 4 5 . stop 20 0 1 6 .  
  fi
fi
```

In diesem Script wird dann die Konfiguration der Programme erledigen,
die nicht durch Kopieren von Dateien erledigt werden kann. Für die
anderen Scripte gelten dieselben Beschränkungen. Sie haben aber dieselbe
Syntax und deswegen verzichte ich jetzt auf die Darstellung eines
`prerm`-Scripts.

Bauen des Paketes
+++++++++++++++--

Mal angenommen, die oben dargestellten Ordner und Dateien befinden sich
im Ordner `updatepackage` und wir befinden uns im übergeordneten
Verzeichnis, dann würden wir mit folgendem Befehl das Paket manuell
bauen.

```
you@host $] dpkg -b updatepackage updatepackage.deb
```

Im Verzeichnis sollte sich jetzt die Datei `updatepackage.deb` befinden,
welche man z.B mit `dpkg -i meinpackage.deb` installieren könnte.
