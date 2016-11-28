+++
layout = "post"
title = "cifs: Mounten einer Samba-Freigabe von der Konsole"
date = "2012-12-31"

+++

>
> Dieser Artikel wurde von [tuxorials.de](http://tuxorials.de) (Dokuwiki) hierher migriert!
> Mögliche Darstellungsfehler bitte ich zu entschuldigen.
>


Dieser kurze Artikel erklärt die Vorgänge beim Mounten einer
Samba-Freigabe von einem Linux-Host aus.

Sie müssen die Pakete installieren, die das Programm `mount.cifs`
enthalten. Da dies von Distribution zu Distribution extrem differiert,
beschreibe ich das distributionsneutral. In dem Szenario 1, welches
ebenfalls hier vorhanden ist, wird eine Konfiguration vorgestellt, die
die Freigaben für den Guest-Account verfügbar macht. Dies soll hier
aufgegriffen werden.

Mit dem folgenden Befehl mounten Sie die Freigabe mit dem Namen
`Downloads` vom Server mit der Adresse `192.168.1.10` nach `/mnt`. Es
wird als Benutzer der Gast-Account verwendet:

```
root@host #] mount -t cifs -o guest //192.168.1.10/Downloads /mnt
```

Wenn Sie die Freigabe wieder aus dem System entfernen wollen, verwenden
Sie den folgenden Befehl:

```
root@host #] umount /mnt
```
