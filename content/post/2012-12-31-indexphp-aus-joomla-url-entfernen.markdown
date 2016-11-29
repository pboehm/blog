+++

tags = ["tuxorials", "german"]
layout = "post"
title = "index.php aus Joomla-URL entfernen"
date = "2012-12-31"

+++

>
> Dieser Artikel wurde von [tuxorials.de](http://tuxorials.de) (Dokuwiki) hierher migriert!
> Mögliche Darstellungsfehler bitte ich zu entschuldigen.
>


In Verbindung mit dem Umzug meiner Seite zu bplaced.net kam es zu einer
Änderung in der Suchmaschinenoptimierung, sodass alte Beiträge nicht
mehr erreichbar waren (404-Fehler). Wie die Lösung des Problems ist,
zeigt dieser Artikel.

Die Lösung dieses Problems ist das Apache-Modul mod\_rewrite, welches
die URLs, die von den Clients abgefragt werden, manipulieren kann. Das
Problem bestand darin, dass die URLs beim Vorherigen Anbieter so
gestaltet waren (Man beachte das index.php).

```
http://www.tuxorials.de/index.php/linux-tipps/fedora/4-canon-pixma-mp210-unter-fedora.html
```

Beim neuen Anbieter war es mir nicht möglich, dass alte Verhalten so
herzustellen und so sahen die URLs nun wie folgt aus.

```
http://www.tuxorials.de/linux-tipps/fedora/4-canon-pixma-mp210-unter-fedora.html
```

Unter dieser Adresse sind die Artikel dann auch erreichbar, jedoch haben
die Suchmaschinen die alten URLs in ihren Indizes und so führten
jegliche Zugriffe von einer Suchmaschine zu einem 404-Fehler, was selten
erwünscht ist. Die Lösung ist, dass man die .htaccess-Datei im
Root-Verzeichnis von Joomla um folgende Zeilen erweitert, sodass aus
jeglichen URLs die ein index.php beinhalten das index.php getilgt wird.
Diese Zeilen müssen nach dem Statement “`RewriteEngine On`“ stehen.

```
RewriteCond %{REQUEST_URI} (.*)index.php(/.*) [NC] 
RewriteRule ^(.*) %1%2 [L]
```

Damit die Regeln Anwendung findet, muss die vorhandene `htaccess`-Datei
in `.htaccess` umbenannt werden. Das erste Statement extrahiert, mit
Hilfe einer Regular Expression, die URL-Bestandteile vor und nach dem
index.php und diese Teile werden dann in der zweiten Regel durch %1 und
%2 wieder zusammengefügt. %1 steht dabei für den Teil vor dem index.php.
