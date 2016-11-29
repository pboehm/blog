+++

tags = ["tuxorials", "german"]
layout = "post"
title = "Wifi deaktivieren wenn LAN-Verbindung besteht"
date = "2012-12-31"

+++

>
> Dieser Artikel wurde von [tuxorials.de](http://tuxorials.de) (Dokuwiki) hierher migriert!
> Mögliche Darstellungsfehler bitte ich zu entschuldigen.
>


Folgendes Problem trat bei mir häufiger auf: „Mein Notebook hatte eine
WLAN-Verbindung hergestellt und ich steckte ein Netzwerkkabel ein um die
volle Bandbreite des Kabels zu nutzen. Da jetzt beide Interfaces aktiv
waren und auch beide im gleichen Netz hingen, gab es ein Problem was
dazu führte, das einfach gar kein Netzwerkverkehr mehr erfolgreich war.“
Ein Script zur Lösung wird hier vorgestellt.

Folgendes Script, muss in das Verzeichnis
`/etc/NetworkManager/dispatcher.d/`, z.B. unter dem Namen `99wlan`
abgelegt werden und mittels `chmod` ausführbar gemacht werden. Die
Scripte in diesem Ordner werden dann aufgerufen, wenn ein Interface hoch
oder runter gefahren wird. Dabei ist der erste Parameter der Name des
Interface (z.B. em1) und als zweiter Parameter der Status (`up`,
`down`).

Das Script deaktiviert Wifi, wenn eine LAN-Verbindung aufgebaut wird und
aktiviert es wieder, wenn keine LAN-Verbindung mehr besteht. Die
Interface-Namen müssen möglicherweise angepasst werden, was aber für
jeden möglich sein sollte.
