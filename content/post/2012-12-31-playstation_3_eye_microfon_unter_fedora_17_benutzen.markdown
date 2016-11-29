+++

tags = ["tuxorials", "german"]
layout = "post"
title = "Playstation 3 Eye Microfon unter Fedora 17 benutzen"
date = "2012-12-31"

+++

>
> Dieser Artikel wurde von [tuxorials.de](http://tuxorials.de) (Dokuwiki) hierher migriert!
> Mögliche Darstellungsfehler bitte ich zu entschuldigen.
>


Wenn pulseaudio das Microfon der Playstation 3 Kamera nicht automatisch
initialisiert, müssen wir ein wenig nachhelfen. Als erstes zeigen wir
uns unsere Soundkarten an.

```
cat /proc/asound/cards
```

Die PS3 Eye wird als CameraB409241 angezeigt seine ID ist die 1.

```
1 [CameraB409241  ]: USB-Audio - USB Camera-B4.09.24.1
                      OmniVision Technologies, Inc. USB Camera-B4.09.24.1 at
                      usb     -0000:00:1a.0-1.2, hi
```

Pulseaudio liest die default.pa beim Start um die Soundkarten zu
initialisieren. In diese Datei schreiben wir nun die Playstation 3 Eye,
damit sie auch beim Start geladen wird.

```
sudo echo "load-module module-alsa-source device=hw:1,0" >> /etc/pulse/default.pa
```

(device=hw:ID,0) Beim nächsten Start sollte das Microfon benutzt werden
können.
