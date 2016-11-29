+++

tags = ["tuxorials", "german"]
layout = "post"
title = "Fedora 16 Samsung-Laptop Display-Flackern entfernen"
date = "2012-12-31"
+++

>
> Dieser Artikel wurde von [tuxorials.de](http://tuxorials.de) (Dokuwiki) hierher migriert!
> Mögliche Darstellungsfehler bitte ich zu entschuldigen.
>


Ein Problem, welches schon in den letzten Tagen von [Fedora 15](http://fedoraproject.org "http://fedoraproject.org") aufgetreten
ist, hat sich in Fedora 16 noch verschlimmert. Es handelt sich dabei um
einen Bug bei der Änderung der Display-Helligkeit bei Samsung Notebooks,
die den Treiber `samsung_laptop` verwenden. Bei Fedora 15 kam dann ein
kurzes Flackern, was noch auszuhalten war. In Fedora 16 ist das Problem
nun so akut, dass beim Ändern der Displayhelligkeit, das Flackern nicht
wieder aufhört, bis das System einfriert. Eine Lösung für das Problem
liefert dieser Beitrag.

Das oben [beschriebene Problem](https://bugzilla.redhat.com/show_bug.cgi?id=747560 "https://bugzilla.redhat.com/show_bug.cgi?id=747560")
ist wohl bekannt, und entsprechende Änderungen sind in Kernel 3.2
integriert, jedoch ist dieser Kernel noch nicht releast und alle
aktuellen Distributioen setzten entweder auf 3.0 oder 3.1 und enthalten
deshalb diesen Fehler. Ich sah mich gezwungen, die [in 3.2 integrierten Patches](https://lkml.org/lkml/2011/5/13/150 "https://lkml.org/lkml/2011/5/13/150")
auf den aktuellen Fedora-Kernel anzuwenden und einen [eigenen Kernel](http://fedoraproject.org/wiki/Building_a_custom_kernel "http://fedoraproject.org/wiki/Building_a_custom_kernel")
zu bauen.

Um den gepatchten Kernel zu installieren, speichern Sie folgende Datei
unter dem Namen `tuxorials_kernel.repo` in das Verzeichnis
`/etc/yum.repos.d/` und installieren dann das Paket
`kernel-3.1.0-7.samsungflickerfix.fc16.i686.rpm`.

```
[tuxorials_kernel]
name=Tuxorials Samsung Non-Flickering Kernel
baseurl=http://repos.tuxorials.de/kernel_nonflickering/
enabled=1
gpgcheck=0
```

Bis der Kernel 3.2 releast ist, ist dies eine adäquate Lösung für das
Problem. Sie können die Kernel-Pakete vom Update durch yum ausschließen,
indem Sie `exclude kernel` ind die Datei `/etc/yum.conf` schreiben.
