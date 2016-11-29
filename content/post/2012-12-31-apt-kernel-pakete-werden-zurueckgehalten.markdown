+++

tags = ["tuxorials", "german"]
layout = "post"
title = "apt: Kernel Pakete werden zurückgehalten"
date = "2012-12-31"

+++

>
> Dieser Artikel wurde von [tuxorials.de](http://tuxorials.de) (Dokuwiki) hierher migriert!
> Mögliche Darstellungsfehler bitte ich zu entschuldigen.
>


Die Lösung für das Problem, dass bei `apt-get upgrade` Pakete, die einen
neuen Kernel beinhalten, zurückgehalten werden, ist eigentlich gar kein
Problem sondern nur ein weiterer Befehl der erforderlich ist.

Der Grund dafür ist, dass Ubuntu bzw. Debian das Installieren eines
neuen Kernels nicht als Upgrade, sondern als Distributionsupgrade
ansieht. Dafür gibt es den Befehl:

```
root@host ]# apt-get dist-upgrade
```

bzw.

```
you@host ]$ sudo apt-get dist-upgrade
```

Eine Ausgabe von `apt-get` die diesem Problem entspricht, sieht wie
folgt aus:

```
root@host:~# apt-get upgrade
Paketlisten werden gelesen... Fertig
Abhängigkeitsbaum wird aufgebaut
Lese Status-Informationen ein... Fertig
Die folgenden Pakete sind zurückgehalten worden:
linux-generic linux-headers-generic linux-image-generic linux-restricted-modules-generic
Die folgenden Pakete werden aktualisiert:
libpoppler-glib4 libpoppler4 linux-libc-dev linux-restricted-modules-common  poppler-utils tzdata tzdata-java
7 aktualisiert, 0 neu installiert, 0 zu entfernen und 4 nicht aktualisiert. .....
```
