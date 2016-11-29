+++

tags = ["tuxorials", "german"]
layout = "post"
title = "Fedora auf Samsung N130"
date = "2012-12-31"

+++

>
> Dieser Artikel wurde von [tuxorials.de](http://tuxorials.de) (Dokuwiki) hierher migriert!
> Mögliche Darstellungsfehler bitte ich zu entschuldigen.
>


Wenn Sie im Besitz eines Samsung N130 Netbooks sind und sich über die
Freezes, 5 Minuten nach dem Start, ärgern dann gibt es in diesem Beitrag
die Lösung dafür.

Das Problem, was die Freude an dem, ansonsten sehr guten Netbook,
schmälert, ist die Tatsache, dass sich das N130 nach jedem Starten (egal
ob aus dem Ruhezustand, dem Energiesparen) eine Denkpause von 20
Sekunden genehmigt.

In der /var/log/messages ist dann so ein Eintrag zu sehen:

```
...
[  285.804210] ata1.00: status: { DRDY }
[  290.844079] ata1: link is slow to respond, please be patient (ready=0)
[  295.828084] ata1: device not ready (errno=-16), forcing hardreset
[  295.828105] ata1: soft resetting link
[  296.010535] ata1.00: configured for UDMA/133
[  296.010584] ata1: EH complete
...
```

Das Problem liegt auf Seiten des BIOS, was von Samsung ausgeliefert
wird. Nach 5 Minuten setzt das BIOS nämlich einen Befehl an den
Prozessor ab, dass er sich wenn möglich in die Energiesparmodis begeben
soll, um Energie zu sparen. Dies führt dazu das IRQs verloren gehen,
darunter auch der für den Festplattencontroller und es bis zu 20
Sekunden dauert, bis dies durch einen harten Reset gelöst wird. Samsungs
Versuch, dies mit aktualisierten BIOSen zu lösen, schlug bisher fehl,
weshalb Tejun Heo einen Patch für den Linux-Kernel entwickelte, der das
Problem von Seiten des Kernel löst. Dieser Patch hat es bisher nicht in
die offiziellen Distributionskernel geschafft, weshalb ich mich dazu
veranlasst sah, einen eigenen Fedora-Kernel mit diesem Patch zu bauen.
Der Kernel bezieht sich bisher noch auf Fedora 12 auch wenn es sein
kann, dass im Kernel von Fedora 13 dieser Patch ebenfalls enthalten ist.
Bis dahin biete ich den Kernel in einem eigenen Repository an.

Der Bug-Report und der Patch, der das Verhalten behebt, ist im
Bugtracker auf kernel.org unter [folgendem Link](https://bugzilla.kernel.org/show_bug.cgi?id=14314 "https://bugzilla.kernel.org/show_bug.cgi?id=14314")
zu erreichen.

Bei dem Kernel handelt es sich um den originalen Fedora-Kernel, mit
allen Upstream-Patches und Anpassungen plus eben den erwähnten Patch.
Den Vorgang des Bauens eines eigenen Kernels unter Fedora, wird ein
eigener Artikel beschreiben.

*Konfiguration auf dem N130*

Legen Sie im Verzeichnis `/etc/yum.repos.d/` eine neue Datei mit dem
Namen `n130kernel.repo` an und fügen Sie dort folgenden Inhalt hinein:

```
[n130kernel]
name=N130 Kernel
baseurl=http://tuxorials.spacequadrat.de/kernelrepo
enabled=1
gpgcheck=0
```

Nach einem Update mit `yum update` sollten Sie die neuen Kernel-Pakete
erhalten. Wenn Sie nun einen Reboot durchführen, können Sie den neuen
Kernel testen, der den Zusatz n130 im Versions-String besitzt.

Sollte es zu einer `Kernel Panic` kommen, bitte ich um eine Nachricht
bzw. Kommentar. Sonst Viel Spaß mit Fedora auf dem N130

[UPDATE] Jetzt wo Fedora 13 erschienen ist, war ich erst einmal ziemlich
enttäuscht, weil das neue Fedora-Release noch mit dem Kernel 2.6.33
ausgeliefert wird. Es ist aber schon ein Update auf die Versionen 2.6.24
in Arbeit und sollte in der näheren Zukunft automatisch verteilt werden.
Diese Version beinhaltet speziellen Code, um die bekannten Freezes auf
dem Samsung N130 zu verhindern.

Wenn man mit den Freezes bis zum Kernel-Update nicht mehr leben will,
kann man sich zwei Pakete herunterladen, die einen frühen Build des
Kernels enthalten. Sie haben sich trotz der kurzen Historie als sehr
stabil erwiesen.

Laden Sie sich die beiden folgenden Pakete herunter:

```
kernel und kernel-headers
```

und führen Sie dann folgenden Befehl aus:

```
root@host #] yum localinstall --nogpgcheck /pfad/zudenkernel/kernel*
```

Nach einem Neustart sollte in den neuen Kernel gebootet werden und Sie
können mit einem Blick in die `/var/log/messages` überprüfen, ob der
oben dargestellte Fehler noch auftritt. Bei mir ist das zum Glück nicht
der Fall. Sollte es zu einem Fehler kommen, können Sie beim Booten
einfach einen anderen Kernel auswählen.

Wenn dieses Update auf den Kernel dann endgültig vollzogen ist, ist
Fedora die ideale Distribution für das Samsung N130, denn andere
Distributionen werden erst in Zukunft auf diese Kernel-Version setzen.

Mit Fedora 13 ist es nun auch endlich möglich, die Display-Helligkeit
mit der Tastenkombination `Fn + Up/Down` zu regeln. [/UPDATE]

[2. Update] Ich kann heute (01.09.2010) bestätigen, dass Fedora
offiziell den Kernel 2.6.34-6 verteilt. [/2. UPDATE]
