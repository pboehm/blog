+++

tags = ["tuxorials", "german"]
layout = "post"
title = "passwd: Passwort setzen per Shell-Script"
date = "2012-12-31"

+++

>
> Dieser Artikel wurde von [tuxorials.de](http://tuxorials.de) (Dokuwiki) hierher migriert!
> Mögliche Darstellungsfehler bitte ich zu entschuldigen.
>


Ein Problem bei der Verwendung von `passwd` in Shell-Scripten ist die
interaktive Eingabe, sodass die Ausführung nicht automatisiert
durchgeführt werden kann. Es ist aber auch ein Problem, wenn das
Passwort im Script weiterverwendet werden soll, um es z.B in einer
Datenbank zu speichern. In früheren Versionen hatte `passwd` eine Option
`–stdin`, welche in aktuellen Versionen aber nicht mehr vorhanden ist.
Die Alternative ist Inhalt dieses Beitrags.

Abhilfe schafft das Programm `chpasswd`, welches mit einer bestimmten
Syntax das Setzen des Passwort per Shell-Script ermöglicht:

*Syntax:*

```
chpasswd << EOT 
${username}:${password}
EOT
```

`chpasswd` werden mit Hilfe der Eingabeumleitung zwei Shell-Variablen
übergeben, bis das Steuerzeichen EOT (End Of Transmisson) übergeben
wird.
