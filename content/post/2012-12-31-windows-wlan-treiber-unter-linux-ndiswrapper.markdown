+++

tags = ["tuxorials", "german"]
layout = "post"
title = "Windows WLAN-Treiber unter Linux: ndiswrapper"
date = "2012-12-31"

+++

>
> Dieser Artikel wurde von [tuxorials.de](http://tuxorials.de) (Dokuwiki) hierher migriert!
> Mögliche Darstellungsfehler bitte ich zu entschuldigen.
>


Wenn es für Ihre Netzwerkhardware keine oder nur ungenügende Treiber
gibt, Sie aber im Besitz der Windows-Treiber sind, gibt es die
Möglichkeit, diese Treiber mit Hilfe des Programms ndiswrapper unter
Linux zu benutzen.

Wenn ein alternativer Treiber im Kernel vorhanden ist, Sie mit diesem
aber nicht zufrieden sind, müssen Sie dieses Modul erst einmal entfernen
und dann vom Start ausschließen. Als Beispiel soll hier der
WLAN-USB-Stick Netgear WG111v3 dienen. Für diesen WLAN-Chip gibt es in
aktuellen Kerneln einen Treibern, der bei mir aber Performance-Probleme
zeigte. Der Name des Treibers ist rtl8187.

Ich gehe davon aus, dass Sie ndiswrapper als Paket installiert oder aus
den Quellen kompiliert haben.

Mit

```
root@host ]# lsmod | grep [treibername]
```

z.B

```
root@host ]# lsmod | grep rtl8187
```

ermitteln Sie, ob der jeweilige Treiber/Modul geladen ist. Wenn ja
entfernt man ihn mit folgendem Befehl aus dem laufenden Kernel:

```
root@host ]# modprobe -r rtl8187
```

Um dieses Modul nun dauerhaft auszuschließen, muss folgende Zeile in die
`/etc/modprobe.d/blacklist.conf` hinzugefügt werden:

```
blacklist rtl8187
```

Nun müssen Sie die Windows-Treiber in Form einer `inf`- und einer
`sys`-Datei besitzen. Den Windows-Treiber für den WG111v3 gibt es unter
folgenden URL zum Download:

```
http://www.avengergear.com/upload/WG111v3.tar.bz2
```

Geben Sie jetzt folgenden Befehl ein, um den Windows-Treiber mit
ndiswrapper zu installieren:

```
root@host ]# ndiswrapper -i /pfad/zur/inf/Datei
```

z.B.

```
root@host ]# ndiswrapper -i /usr/share/WG111v3.inf
```

Dieser Befehl wird mit einem Fehler abgebrochen, falls in dem selben
Verzeichnis keine `sys`-Datei vorhanden ist. Ob der Treiber richtig
installiert wurde, ermitteln Sie mit folgendem Befehl:

```
root@host ]# ndiswrapper -l
```

Beispielausgabe:

```
you@host ~ $ ndiswrapper -l 
wg111v3 : driver installed  
device (0846:4260) present (alternate driver: rtl8187)
```

Mit folgendem Befehl laden Sie das ndiswrapper-Modul mit dem
installierten Window-Treiber in den Kernel:

```
root@host ]# modprobe ndiswrapper
```

In früheren Versionen musste man noch ein `modprobe -ma`
hinterherschicken. Diese Parameter kennen die aktuellen Versionen von
ndiswrapper nicht mehr und sie werden auch nicht mehr benötigt. Sie
sollten nun mit Ihrem WLAN-Chip arbeiten können.
