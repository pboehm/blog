+++

tags = ["tuxorials", "german"]
layout = "post"
title = "Arbeit mit iso-Files unter Linux"
date = "2012-12-31"

+++

>
> Dieser Artikel wurde von [tuxorials.de](http://tuxorials.de) (Dokuwiki) hierher migriert!
> Mögliche Darstellungsfehler bitte ich zu entschuldigen.
>


Die Bereitstellung von CD-Abbildern in Form von iso-Dateien ist in der
Open-Source-Welt sehr beliebt und deswegen widme ich einem Beitrag der
Verwendung dieser Files unter Linux. Die Norm ISO 9660 beschreibt die
Richtlinien für das Dateisystem von CDs bzw. DVDs, woraus auch die
Dateiendung entsteht.

Mounten von normalen iso-Files
++++++++++++++++++++++++++++++

Um auf den Inhalt von iso-Dateien zugreifen zu können muss die Datei
eingehängt (gemountet) werden. Ich bevorzuge die Methode per
`mount`-Befehl, es gibt aber auch noch die Möglichkeit z.B über `cdemu`.
Ich werde mich aber auf den `mount`-Befehl beschränken, da er ohne
weitere Pakete zu installieren, vorhanden ist. Für das Mounten, werden
administrative Rechte gebraucht.

Der Befehl:

```
root@host:# mount -o loop -t 9660 /path/to/isofile /mountpoint
```

Beispiel: (Einhängen der Gasterweiterung für Virtualisierungssoftware
VirtualBox)

```
root@host:# mount -o loop -t 9660 /home/philipp/.VirtualBox/VBoxGuestAdditions_3.0.4.iso /mnt
```

*Was bedeutet der Befehl nun:*

-   `mount` ist der Befehl zu Einhängen anderer Dateisysteme in das
    lokale Dateisystem
-   `-o loop` mountet das iso als Loopback-Device, was eine Mischform
    der beiden gängigsten Device-Typen (Block- und Characterdevices)
    darstellt
-   `-t 9660` legt das Dateisystem für das iso-File fest (kann auch weg
    gelassen werden)
-   `/path/to/iso-file` ist der Pfad zum Iso-File
-   `/mountpoint `ist ein Ordner in dem das CD-Abbild eingehängt wird
    z.B. `/mnt` oder jeder beliebige Ordner

*Wie kann man das iso-File wieder aushängen:*

Für das Aushängen eines Dateisystems gibt es das Gegenstück zum
`mount`-Befehl, nämlich den `umount`-Befehl, welcher jetzt kurz
dargestellt wird.

Der Befehl:

```
root@host:# umount /mountpoint
```

Bsp:

```
root@host:# umount /mnt
```

Alternative CD-Abbilder mounten
++++++++++++++++++++++++++++++-

Natürlich gibt es zu iso-Dateien zahlreiche Alternativen wie `nrg`,
`bin/cue`, `mdf/mds`, die sich meistens im Dateisystem nicht
unterscheiden, also mein Tipp: einfach mal mit dem oben dargestellten
`mount`-Befehl probieren, wenn es nicht geht wird `mount` eine
Fehlermeldung erzeugen.

bin/cue-Abbilder
+++++++++++++++-

Eine Ausnahme beim Mounten bilden die Abbilder, die in zwei Dateien mit
den Endungen `.bin` und `.cue` aufgeteilt sind. Diese können nativ nicht
mit Linux gemountet werden, aber dafür gibt es das Programm `bchunk`,
welche die bin/cue-Dateien in ein iso-Abbild konvertiert.

Installieren Sie also das Paket bchunk mit Ihrem Paket-Verwaltungsystem
(`apt`, `yum`, `zypper` …) und wenden Sie folgenden Befehl an:

```
you@host:$ bchunk /path/to/bin path/to/cue basename
```

Bsp:

```
you@host:$ bchunk image.bin image.cue result
```

Danach wird sich in dem Ordner ein iso-File befinden.

Erstellen von iso-Abbildern von einer CD
+++++++++++++++++++++++++++++++++++++++-

Jetzt wo wir das das Mounten von iso-Dateien besprochen haben, wenden
wir uns dem Erstellen von iso-Dateien aus jeglichen Devices zu. Als
Beispiel soll das Erstellen eines iso-Abbilds von einer normalen 700MB
CD dienen.

```
you@host:$ dd if=/dev/srcdevice of=/path/to/iso bs=2048
```

Bsp:

```
you@host:$ dd if=/dev/scd0 of=/home/philipp/Desktop/ubuntu904.iso bs=2048
```

Nach einiger Zeit und Rauschen des DVD-Laufwerks erscheint im
Ziel-Ordner die entsprechende iso-Datei.

*Das bedeutet der Befehl:*

-   `dd` ist der Befehl für das bitweise Kopieren
-   `if=/dev/srcdevice` ist der Pfad zum Quell-Device von dem das Abbild
    erstellt werden soll (Achten Sie auf das Gleichheitszeichen)
-   `of=/path/to/iso` ist der Pfad zum zu erstellenden iso-File
-   `bs=2048` gibt die entsprechende Blocksize für das Dateisystem an
    (Für CDs/DVDs ist das 2048, für andere Dateisysteme ist das
    abweichend)

Wenn Sie das iso-File erstellt haben nutzen Sie den `mount`-Befehl um es
einzuhängen.
