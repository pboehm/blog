+++
layout = "post"
title = "PDF-Dateien von Passwörtern befreien"
date = "2012-12-31"

+++

>
> Dieser Artikel wurde von [tuxorials.de](http://tuxorials.de) (Dokuwiki) hierher migriert!
> Mögliche Darstellungsfehler bitte ich zu entschuldigen.
>


Ein Thema, welches mich seit dem Beginn meines Studiums beschäftigt, ist
das Entfernen von Passörtern aus PDF-Dateien, weshalb ich hier meine
Erfahrungen schildern werde.

Für das Verändern von PDF-Dateien gibt es unter Linux und anderen Unixen
zahlreiche Tools, darunter
[pdftk](http://www.pdflabs.com/tools/pdftk-the-pdf-toolkit/ "http://www.pdflabs.com/tools/pdftk-the-pdf-toolkit/"),
[qpdf](http://qpdf.sourceforge.net/ "http://qpdf.sourceforge.net/") und
Ghostscript, wobei Ghostscript nachfolgend als Lösung für das
Passwort-Problem genutzt wird, aber noch wesentlich mehr kann.

Für Passwörter scheint es in PDF-Dateien ingesamt drei Standards zu
geben, wobei der dritte AES benutzt und nicht in allen Tools
implementiert ist. Nun wurde aber gerade dieser Algorithmus in den
vorliegenden PDF-Dateien eingesetzt und so blieben nur noch `qpdf` und
Ghostscript übrig.

Da `qpdf` nicht in den Repositories von Fedora vorhanden ist, muss es
händisch kompiliert werden, was die devel-Pakete von `zlib` und `pcre`
benötigt. Unter CentOS 6 bricht das Kompilieren aber mit einem obskuren
Fehler ab und kann deshalb auf dem entsprechenden Server nicht genutzt
werden.

Deshalb blieb als letzter Ausweg nur noch
[Ghostscript](http://www.ghostscript.com/Ghostscript "http://www.ghostscript.com/Ghostscript"),
welches eigentlich auf jedem Unix-System installiert sein sollte.

Folgender Befehl entfernt das Passwort aus einer PDF-Datei und schreibt
eine neue Version der PDF, ohne Passwort. Dabei wird das Passwort direkt
als Parameter angegeben. Es gibt wohl auch die Möglichkeit, dass
Ghostscript das Passwort einfach unterschlägt und damit dann auch
unbekannte Passwörter entfernen kann, jedoch klappt dies wohl nicht
immer.

```
gs -q -dNOPAUSE -dBATCH -sDEVICE=pdfwrite -sOutputFile=withoutpassword.pdf -sPDFPassword=INSERTPASSWORDHERE -c .setpdfwrite -f filewithpassword.pdf
```
