+++
layout = "post"
title = "Tuxorials yum-Repository"
date = "2012-12-31"

+++

>
> Dieser Artikel wurde von [tuxorials.de](http://tuxorials.de) (Dokuwiki) hierher migriert!
> Mögliche Darstellungsfehler bitte ich zu entschuldigen.
>


Um meine selbst erstellte Software komfortabel für Distributionen wie
Fedora bereitzustellen, baue ich seit langem daraus RPM-Pakete. Diese
RPM-Pakete stelle ich per Repository bereit, welches nur noch zu Ihrem
System hinzugefügt werden muss.

Legen Sie im Ordner `/etc/yum.repos.d/` eine Datei mit dem Namen
`tuxorials.repo` an und füllen Sie sie mit folgendem Inhalt:

```
[tuxorials] 
name=Tuxorials 
baseurl=http://repos.tuxorials.de/fedora$releasever 
enabled=1 
gpgcheck=0
```

Na einem Update der Paketinformationen stehen Ihnen Pakete wie
`serienrenamer`, `srcpackager` oder `pkgbuilder` zur Installation
bereit.
