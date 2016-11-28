+++
layout = "post"
title = "Teil 1: Starten von Shell-Scripten"
date = "2012-12-31"

+++

>
> Dieser Artikel wurde von [tuxorials.de](http://tuxorials.de) (Dokuwiki) hierher migriert!
> Mögliche Darstellungsfehler bitte ich zu entschuldigen.
>


Im ersten Teil der Serie, rund um die Shell-Programmierung, befassen wir
uns heute mit den Möglichkeiten des Startens bzw. Ausführens eines
Shell-Scriptes.

  Um die Möglichketen des Ausführens zu erläutern erstellen Sie bitte
eine Datei auf Ihrem Desktop mit dem Namen script1.sh
(`touch Desktop/script1.sh`) und öffnen Sie sie in einem beliebigen
Editor und geben dort folgenden Inhalt ein:

```
echo "Dies ist mein erstes Shell-Script"
```

Dieses Scripts ist zwar alles andere als sinnvoll aber es reicht für den
Anfang aus. Es wird also beim Ausführen des Shell-Scripts der Text „Dies
ist mein erstes Shell-Script“ in der Shell ausgeführt.

Bloß wie führt man dieses Script jetzt aus?
++++++++++++++++++++++++++++++++++++++++++-

### Direktes Ausführen durch die Bash als Argument

Dies ist die einfachste aller Möglichkeiten, wo die Datei an den Befehl
der Shell übergeben wird und durch sie interpretiert wird. Meiner
Meinung nach ist dies aber nicht die ideale Möglichkeit, denn es können
keine Inkompatibilitäten zwischen den Shells verhindert werden.

*Der Befehl:*

```
you@host ]$ bash Desktop/script1.sh
```

Wie nicht anders zu erwarten war, wird der an `echo` übergebene Text im
Terminal ausgegeben. Wenn Sie sich momentan nicht in Ihrem
Home-Verzeichnis befinden, müssen Sie den Pfad zur Datei anpassen.

### Einfügen einer She-Bang-Zeile in das Shell-Script

Dies ist die bessere der Methoden auch wenn der Name etwas kompliziert
wirkt, aber es bedeutet nur, dass als erste Zeile im Script, die Shell
angegeben wird, welche das Script ausführen soll.

*Die She-Bang-Zeile hat folgendes Format:*

```
#!/pfad/zur/shell
```

z.B.

```
#!/bin/bash
```

Bloß, was bringt uns das für Vorteile, bisher gar keine, aber das ändert
sich jetzt. Um das Script selbst ausführen zu können, muss es ausführbar
gemacht werden d.h. das Script kann ohne das Aufrufen der Shell
ausgeführt werden.

#### Das Script ausführbar machen:

```
you@host ]$ chmod u+x Desktop/script1.sh
```

Durch den Befehl `chmod` können die Dateiattribute geändert werden und
das `u+x` bedeutet, dass das Script für den Besitzer der Datei
ausführbar gemacht wird.

*Ausführen des Scripts:*

```
you@host ]$ Desktop/script1.sh
```

oder, wenn Sie sich schon im Verzeichnis befinden, wo sich die Datei
befindet:

```
you@host ]$ ./script1.sh
```

Wenn sich der Ordner, in welchem Sie das Script angelegt haben, in der
`PATH`-Shellvariable befindet, können Sie das Script einfach durch
Aufruf des Namen aus jedem Ordner aufrufen.

```
you@host ]$ script1.sh
```

Zusammenfassung:
+++++++++++++++-

1.  Script-Datei anlegen
2.  She-Bang-Zeile und das eigentliche Script in diese Datei schreiben
3.  Script speichern
4.  Script ausführbar machen (chmod u+x), dies muss nur einmal gemacht
    werden
5.  Script ausführen

Die anderen Belange der Shell-Programmierung werden in den folgenden
Teilen dieser Serie behandelt
