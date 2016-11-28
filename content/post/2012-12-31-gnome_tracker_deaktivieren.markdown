+++
layout = "post"
title = "Gnome 3: tracker deaktivieren"
date = "2012-12-31"

+++

>
> Dieser Artikel wurde von [tuxorials.de](http://tuxorials.de) (Dokuwiki) hierher migriert!
> Mögliche Darstellungsfehler bitte ich zu entschuldigen.
>


Wem das Tool `tracker` (oder auch `tracker-miner-fs` …) durch dauerhafte
Festplattenzugriffe und hohe Systemlast aufgefallen ist, aber bisher
keinen Weg gefunden hat, es zu deaktivieren, der sollte folgendes tun:

Im Verzeichnis `/etc/xdg/autostart` müssen alle Dateien, welche
`tracker` im Namen tragen, um folgende Zeile erweitert werden, damit
`tracker` global deaktiviert wird:

```
Hidden=true
```
