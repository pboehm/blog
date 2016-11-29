+++

tags = ["tuxorials", "german"]
layout = "post"
title = "motd bei SSH-Login"
date = "2012-12-31"

+++

>
> Dieser Artikel wurde von [tuxorials.de](http://tuxorials.de) (Dokuwiki) hierher migriert!
> Mögliche Darstellungsfehler bitte ich zu entschuldigen.
>


Wenn Sie sich einmal per `SSH` auf einen typischen Linux-Rechner
angemeldet haben, wird Ihnen sicher aufgefallen sein, dass als letzte
Zeile jeweils der Hostname des Rechners steht, von dem der letzte Login
geschah. Wie Sie diese Zeile entfernen, beschreibt dieser Beitrag.

Anfangs wollte ich einmal kurz einen Auschnitt einer Message Of The Day
(motd) darstellen, welche typisch für eine Ubuntu-Installation ist:

```
The programs included with the Ubuntu system are free software; the exact
distribution terms for each program are described in the individual files in
/usr/share/doc/*/copyright.  
.
Ubuntu comes with ABSOLUTELY NO WARRANTY, to the extent permitted by 
applicable law.
.
To access official Ubuntu documentation, please visit: 
http://help.ubuntu.com/
.
System information as of Wed Apr 21
......
Last login: Tue Apr 20 21:56:44 2010 from test.example.org
```

Wen die letzte Zeile stört, bekommt mit einem kleinen Eingriff in die
Datei `/etc/ssh/sshd_config` das gewünschte Verhalten konfiguriert.
Öffnen Sie dazu die entsprechende Datei mit Ihrem Lieblingseditor
(root-Rechte sind erforderlich) und setzen Sie folgende Direktive
entsprechend:

```
...
PrintLastLog no
...
```

Anschließend müssen sie den SSH-Server neu starten, damit die
Konfigurationsdatei neu geparst werden kann. Dies geschieht zum Beispiel
mit folgendem Befehl:

```
root@host #] service ssh restart
```
