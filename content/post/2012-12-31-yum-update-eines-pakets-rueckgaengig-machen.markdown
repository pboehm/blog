+++

tags = ["tuxorials", "german"]
layout = "post"
title = "yum: Update eines Pakets rückgängig machen"
date = "2012-12-31"

+++

>
> Dieser Artikel wurde von [tuxorials.de](http://tuxorials.de) (Dokuwiki) hierher migriert!
> Mögliche Darstellungsfehler bitte ich zu entschuldigen.
>


Wenn sich durch ein Paketupdate mit Hilfe von `yum` ein Fehler in das
System eingeschleust hat, gibt es die Möglichkeit auf eine frühere
Version des Pakets zu wechseln. Das und die Möglichkeit zum Ausschluss
eines Pakets vom Update erklärt dieser Artikel.

Im Rahmen des Umstiegs auf Fedora 13 kam es auch zu einem Versionssprung
bei der Software `hostapd`, welche ich dafür einsetze, anderen Leuten
einen WLAN-Zugriff durch mein Netbook zu ermöglichen. Dieser
Versionssprung schleuste aber einen Fehler ein, der die folgende
Fehlermeldung produziert:

```
Could not set DTIM period for kernel driver
```

Eine Hinweis im Bugtracker des gentoo-Projekts lautete, von der Version
0.6.10 auf die lauffähige 0.6.9 zu wechseln. Wenn man eine Distribution,
die auf `yum` als Paketmanager setzt, einsetzt, gibt es die Möglichkeit
mit folgendem Befehl, jedes Paket auf die vorherige Version
downzugraden. Ich habe bisher jedoch nur die Situation gehabt, dass die
vorherige Version des Pakets bereits installiert war. Ob die Funktion
auch frühere Pakete aus den Repositories holt, kann ich nicht sagen.

```
root@host #] yum downgrade [paketname]
```

oder am Beispiel von hostapd:

```
root@host #] yum downgrade hostapd
```

Dies brachte mir eine lauffähige Version von `hostapd`. Beim nächsten
Update wird dieser Downgrade aber wieder durch die neuere Version
aufgehoben, weshalb ich mich dazu entschlossen habe, `hostapd` vom
Update auszuschließen.

Um Pakete vom Update durch `yum` auszuschließen, fügen Sie folgende
Zeile an die Datei `/etc/yum.conf` an:

```
exclude=paketname
```

oder:

```
exclude=hostapd
```

Dabei können auch Wildcarts wie das Sternchen \* verwendet werden, um
z.B. alle Pakete von OpenOffice vom Update auszuschließen.
