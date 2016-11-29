+++

tags = ["tuxorials", "german"]
layout = "post"
title = "NFS mount-Problem beim Booten"
date = "2012-12-31"

+++

>
> Dieser Artikel wurde von [tuxorials.de](http://tuxorials.de) (Dokuwiki) hierher migriert!
> Mögliche Darstellungsfehler bitte ich zu entschuldigen.
>


Das hier beschriebene Problem, tritt vereinzelt und auch nur zeitweise
bei einigen Ubuntu-Installationen auf. Es besteht darin, dass der
Rechner mit DHCP eingerichtet ist und die in der `/etc/fstab`
festgelegten NFS-Mounts nicht ausgeführt werden können.

Ich erkläre mir das so, dass durch den Umstieg auf Upstart, der
Bootvorgang parallelisiert wurde und somit ein NFS-Mount-Versuch
durchgeführt wird, wenn dem Netzwerkinterface noch gar keine IP-Adresse
zugewiesen ist. Das Problem besteht schon länger (2008), was der
Launchpad-Bugreport beweist und auch dort tritt es nur vereinzelt auf.

Wenn mann sich nach dem vergeblichen NFS-Mount an einer Shell anmeldet
und dann `mount -a` tippt,wird die NFS-Freigabe erfolgreich gemountet.
Aus dieser Tatsache haben einige Leute einen Workaround geschaffen, der
darin besteht das `mount -a` in die `/etc/rc.local` zu schreiben.

Die Datei `/etc/rc.local` muss wie folgt aussehen:

```
#!/bin/sh -e 
# 
# rc.local 
# 
# This script is executed at the end of each multiuser runlevel. 
# Make sure that the script will "exit 0" on success or any other 
# value on error. 
# 
# In order to enable or disable this script just change the execution 
# bits. 
# 
# By default this script does nothing.  
sleep 5 echo "Warte 5 Sekunden bevor NFS gemountet wird" 
mount -a  
exit 0
```

Danach müssen Sie die Datei ausführbar machen. Dies tun Sie mit
folgendem Befehl:

```
root@host ]# chmod +x /etc/rc.local
```

Beim nächsten Boot-Vorgang sollte das Problem behoben sein. Trotzdem ist
es eigentlich nicht fassbar, dass ein Problem, was seit 2008 besteht und
wie der Bugreport zeigt, auch viele Nutzer betrifft, immer noch nicht
gefixt ist.
