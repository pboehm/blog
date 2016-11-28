+++
layout = "post"
title = "yum Repository erstellen"
date = "2012-12-31"

+++

>
> Dieser Artikel wurde von [tuxorials.de](http://tuxorials.de) (Dokuwiki) hierher migriert!
> Mögliche Darstellungsfehler bitte ich zu entschuldigen.
>


Wenn Sie in der Situation sind, eigene rpm-Pakete erstellen zu müssen
bzw. zu pflegen, werden Sie das Bedürfnis haben, ein eigenes Repository
aufzusetzen. Es bietet den Vorteil, dass Clients dann sehr komfortabel
auf die Pakete zugreifen und diese auch installieren können. Ebenfalls
werden Aktualisierungen automatisch vom Client bezogen.

Alle aktuellen `rpm`-basierten Distributionen bringen als
Paketverwaltungssystem das Programm `yum` mit und dementsprechend werden
auch die Distributionspakete durch ein yum-Repository bereitgestellt.
Dieser Artikel beschreibt das Erstellen eines solchen Repository.

Ich gehe davon aus, dass Sie die Programme `yum` und `createrepo`
installliert haben, was dann gegebenenfalls noch nachgeholt werden muss.
Sollte `createrepo` in Ihrer Distribution nicht vorhanden sein, beziehen
Sie es direkt von der Projektseite unter folgendem Link.

*Repository erstellen* Legen Sie einen Ordner mit einem beliebigen Namen
an, in dem Sie dann die rpm-Pakete hineinkopieren. Wenn das Repository
von mehreren Nutzern erreicht werden soll, sollte es in einem
Webserver-Verzeichnis wie `/var/www/html` (unter Fedora) liegen, das
dann im eigenen Netz erreichbar ist.

```
root@server #] mkdir /var/www/html/repo 
root@server #] cp *.rpm /var/www/html/repo/
```

Den zweiten Befehl müssen Sie natürlich an Ihre Gegebenheiten anpassen
aber zur Vollständigkeit musste der halt auch da stehen.

Für ein Repository müssen einfach ein paar spezielle Dateien erzeugt
werden, die die Inhalte der rpm-Pakete zusammenfassen und von den
Client-yum-Installationen interpretiert werden. Dafür kommt das
entsprechende `createrepo` zum Einsatz. Es bekommt einfach den Pfad zu
den rpm-Paketen übergeben und arbeitet dann völlig automatisch.

```
root@server #] createrepo /var/www/html/repo/ 
11/11 - serienindexer-0.6.5-1.fc12.i668.rpm 
Saving file primary metadata 
Saving file lists metadata 
Saving other metadata
```

Mit der Server-Seite war es dass nun eigentlich schon. Falls noch nicht
geschehen starten Sie den Webserver.

*Client-Konfiguration* Auf der Clientseite muss nun ein neues Repository
eingefügt werden, wobei das dann automatisch durch yum aktualisiert
wird.

Legen Sie z.B. die Datei `/etc/yum.repos.d/tuxorials.repo` mit folgendem
Inhalt an:

```
[tuxorials] 
name=Tuxorials 
baseurl=http://tuxorials.spacequadrat.de/repo/ 
enabled=1 
gpgcheck=0
```

Die Werte müssen Sie natürlich anpassen aber es bietet ein
funktionierendes Beispiel, was Zugriff zu Software bietet, die von mir
geschrieben wurde. Führen Sie nun ein `yum update` durch, was Ihnen
schon zeigen dürfte, wie er die Repository-Daten bezieht und danach
können Sie wie üblich mit `yum install packagename` die Pakete
installieren.
