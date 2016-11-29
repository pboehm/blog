+++

tags = ["tuxorials", "german"]
layout = "post"
title = "Thinkpad WLAN LED beruhigen"
date = "2012-12-31"

+++

>
> Dieser Artikel wurde von [tuxorials.de](http://tuxorials.de) (Dokuwiki) hierher migriert!
> Mögliche Darstellungsfehler bitte ich zu entschuldigen.
>


Eine Sache, die einem bei einem Thinkpad (z.B. T520) nerven könnte, ist
das Blinken der WLAN-LED bei Netzwerkzugriffen. Dies lässt sich durch
einen Kernelmodul-Parameter beim WLAN-Treiber `iwlwifi` ändern. Dabei
hat sich das Tool `modinfo` als nützlich erwiesen, da es die vorhandenen
Parameter von Kernelmodulen ausgeben kann. Der Befehl

```
# modinfo iwlwifi
....
parm: led_mode:0=system default, 1=On(RF On)/Off(RF Off), 2=blinking (default: 0) (int)
....
```

liefert uns auch den entspechenden Parameter, welcher dann durch
`modprobe` an `iwlwifi` übergeben wird. Es muss nun eine Datei
`/etc/modprobe.d/iwlwifi.conf` angelegt werden und die muss folgende
Zeile enthalten:

```
options iwlwifi led_mode=1
```

damit die LED nun bei aktiver Verbindung dauerhaft leuchtet. Nachfolgend
muss dann der `iwlwifi` neu geladen werden.

```
modprobe -r iwlwifi
modprobe iwlwifi
```
