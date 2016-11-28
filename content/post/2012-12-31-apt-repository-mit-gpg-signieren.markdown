+++
layout = "post"
title = "apt-Repository mit GPG signieren"
date = "2012-12-31"

+++

>
> Dieser Artikel wurde von [tuxorials.de](http://tuxorials.de) (Dokuwiki) hierher migriert!
> Mögliche Darstellungsfehler bitte ich zu entschuldigen.
>


Als Sie damit begonnen haben, Ihr eigenes deb-Paket per Repository
bereitzustellen, kam es zu einer Warnung durch `apt`, dass das Paket
nicht authentifiziert worden konnte. Dies hatte den Grund, dass Ihr
Repository bisher nicht signiert wurde, was aber Inhalt dieses Beitrages
ist.

Führen Sie folgende Befehle aus:

```
root@host #] cd /var/www/repository 
root@host #] mkdir .gnupg 
root@host #] chown root:root .gnupg 
root@host #] chmod 0700 .gnupg 
root@host #] gpg  --homedir .gnupg --gen-key
```

Nach Ausführen des letzten Befehls wird ein `gpg`-Schlüssel erzeugt, was
einige Eingaben erfordert. Bei der Auswahl des Schlüsseltyps wählen Sie
den ersten und wählen nachfolgend eine Schlüssellänge von `2048` und
legen fest, dass der Schlüssel unbegrenzt gültig ist.

Nachfolgend werden Daten wie Vor- und Nachname, Email-Adresse und
Kommentar abgefragt und es wird nach einer Passphrase verlangt. Bei der
Erstellung kann es eine Meldung geben, dass mehr Entropie benötigt wird.
Es muss einfach etwas gewartet werden oder es müssen weitere Programme
ausgeführt werden.

Folgende Befehle müssen ausgeführt werden:

```
root@host #] cd /var/www/repository  
root@host #] gpg --homedir .gnupg --list-keys 
root@host #] gpg --homedir .gnupg --export -a > repo.key
```

Nun haben wir den Public-Key in die Datei `repo.key` ausgelagert, sodass
dieser auf die Clients übertragen werden kann.

**Signieren des Repository**

Der folgende Befehl signiert das custom-repository:

```
root@host #] gpg --homedir /var/www/repository/.gnupg/ \
--output /var/www/repository/dists/custom/Release.gpg \
-ba /var/www/repository/dists/custom/Release
```

Nach der Eingabe der Passphrase, welche oben dargestellt ist, wird das
repository signiert. Es bietet sich an, diesen Befehl in ein Script oder
Alias auszulagern.
