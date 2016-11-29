+++

tags = ["tuxorials", "german"]
layout = "post"
title = "Windows Schriftarten unter Linux"
date = "2012-12-31"

+++

>
> Dieser Artikel wurde von [tuxorials.de](http://tuxorials.de) (Dokuwiki) hierher migriert!
> Mögliche Darstellungsfehler bitte ich zu entschuldigen.
>


Auch wenn es natürlich adäquate freie Alternativen zu den
Standard-Schriftarten von Microsoft gibt, ist es manchmal notwendig,
Schriftarten wie Times New Roman, Calibri oder Comic Sans auch unter
Linux zu besitzen. Ein Grund wäre der Dokumentenaustausch zwischen
mehreren Plattformen oder auch die richtige Darstellung von Webseiten,
wenn dort aus unerfindlichen Gründen Microsoft-spezifische Schriftarten
verwendet werden.

  Für das Problem gibt zwei Lösungsansätze: Kopieren der ttf-Dateien aus
einer Windows-Installation Wenn Sie über eine vorhandene
Windows-Installation verfügen, ist es durch zwei Befehle möglich sich
die Schriftarten zugänglich zu machen. Meiner Meinung nach besteht
dadurch auch kein Lizenz-Verstoß, denn durch das Vorhandensein einer
gültigen Windows-Lizenz entfällt dieser Ansatz. Ich gehe davon aus, dass
Sie die Windows-Systempartition gemountet haben, wenn nicht müssen Sie
für einen anderen Austausch sorgen. Die Schriftarten im ttf-Format (True
Type Font) befinden sich unter Windows im Verzeichnis:
C:\\Windows\\Fonts . Um die Schriftarten kopieren zu können brauchen Sie
root-Rechte, da Sie schreibend auf /usr/share/fonts zugreifen müssen.

```
root@host:# mkdir /usr/share/fonts/win root@host:# cp /path-to-win-partition/Windows/Fonts/*.ttf /usr/share/fonts/win
```

Achtung: Bei einer Vista-Installation werden insgesamt 163 MB an
ttf-Dateien kopiert Installieren eines Paketes Eine andere Möglichkeit
besteht darin, ein in der Distribution verfügbares Paket zu
installieren. Dabei kann man sich aber nicht darauf verlassen, dass
dieses Paket in jeder Distribution in den Paketquellen vorhanden ist.
Ein Beispiel dafür ist Fedora, welche das Paket nicht enthält, hingegen
enthält Ubuntu dieses Paket namens msttcorefonts. Der Befehl unter
Ubuntu wäre also:

```
root@host:# apt-get install msttcorefonts
```
