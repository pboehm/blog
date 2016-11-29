+++

tags = ["tuxorials", "german"]
layout = "post"
title = "ssh: entfernte Befehle ausführen"
date = "2012-12-31"

+++

>
> Dieser Artikel wurde von [tuxorials.de](http://tuxorials.de) (Dokuwiki) hierher migriert!
> Mögliche Darstellungsfehler bitte ich zu entschuldigen.
>


Ein interessantes Feature am SSH-CLient ist die Möglichkeit der
Ausführung entfernter Befehle, ohne sich dabei interaktiv anmelden zu
müssen. Dies ist z.B. für Backup-Zwecke notwendig, die zeitgesteuert mit
Hilfe von `cron` ausgeführt werden.

Um z.B. automatisiert die eingeloggten Nutzer mehrerer Clients zu
erfassen, könnte in einer for-Schleife der folgende Befehl ausgeführt
werden:

```
you@host]$ ssh host /usr/bin/users
```

Um diesen Vorgang wirklich automatisieren zu können, muss eine
passwortfreie Authentifizierung z.B. mit Hilfe einer
Publickey-Authentifizierung eingerichtet werden.

Es können dabei jegliche Befehle ausgeführt werden, die mit den
jeweiligen Rechten des Nutzers ausgeführt werden können.

Bei Befehlen, die eine Bindung an ein Terminal erfordern (wie Editoren)
muss die Kommandozeilenoption `-t` angegeben werden.
