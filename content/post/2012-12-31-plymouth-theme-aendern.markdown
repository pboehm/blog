+++

tags = ["tuxorials", "german"]
layout = "post"
title = "Plymouth-Theme ändern"
date = "2012-12-31"

+++

>
> Dieser Artikel wurde von [tuxorials.de](http://tuxorials.de) (Dokuwiki) hierher migriert!
> Mögliche Darstellungsfehler bitte ich zu entschuldigen.
>


Die Software mit dem Namen Plymouth wird von Fedora zur grafischen
Aufbereitung des Bootvorgangs verwendet. In den Repositorys gibt es
einige Alternativen zum Standard-Theme und somit beschäftigt sich dieser
Beitrag mit dem Ändern des Plymouth-Themes.

Am Anfang sollten Sie die alternativen Themes aus den Paktequellen
nachinstallieren. Dies tun Sie mit folgendem Befehl:

```
root@host ]# yum install plymouth-theme*
```

Nachdem Sie die Themes nachinstalliert haben, können Sie sich mit
folgendem Befehl, die verfügbaren Themes auslesen:

```
root@host ]# plymouth-set-default-theme --list
```

Dies liefert normalerweise eine Liste mit mehr als vier Themes zurück
und mit folgendem Befehl setzen Sie das neue Standard-Theme:

```
root@host ]# plymouth-set-default-theme [theme-name]
```

z.B.

```
root@host ]# plymouth-set-default-theme spinfinity
```

Dies würde beim Start aber noch keine Änderung hervorrufen, denn Sie
müssen erst noch folgenden Befehl ausführen um die `initrd` neu zu
bilden:

```
root@host ]# /usr/libexec/plymouth/plymouth-update-initrd
```

Wenn dieser Befehl bei der Ausführung Fehlermeldungen ausgibt, können
Sie das getrost ignorieren. Es wird sich nicht auf das Systemverhalten
auswirken. Bei einem Neustart werden Sie das neue Boot-Theme begutachten
können.
