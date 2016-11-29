+++

tags = ["tuxorials", "german"]
layout = "post"
title = "eigenes apt-Repository"
date = "2012-12-31"

+++

>
> Dieser Artikel wurde von [tuxorials.de](http://tuxorials.de) (Dokuwiki) hierher migriert!
> Mögliche Darstellungsfehler bitte ich zu entschuldigen.
>


Bei diesem Beitrag handelt es sich um die Darstellung der Konfiguration
eines Programms, dass die für ein Repository nötigen Dateien automatisch
erstellt. Es ist damit möglich, eigene deb-Pakete zu verteilen, wobei
dieser Vorgang Inhalt eines eigenen Artikels war.

Das Programm `apt-ftparchive` müsste standardmäßig installiert sein,
wenn nicht muss es nachinstalliert werden. Ich beschreibe hier die
Erstellung eines Repository mit dem Namen `custom` und darauf sind auch
die Konfigurationen angepasst. Es muss auf dem selben Rechner ein
Webserver, z.B der Apache installiert sein, da ich davon ausgehe, dass
die Pakete für andere bereitgestellt werden sollen.

*folgende Dateien müssen bearbeitet bzw. erstellt werden:*

```
/etc/apt/apt-ftparchive-custom.conf 
/etc/apt/apt-custom-release.conf
```

*Die Verzeichnisstruktur muss folgend angelegt werden:*

```
/var/www/repository/ 
`-- dists  
`   `-- custom  
`       `-- main 
`           `-- binary-i386
```

In das Verzeichnis binary-i386 kommen dann die tatsächlichen Pakete.

Die Datei /etc/apt/apt-ftparchive-custom.conf muss dann wie folgt
aussehen:

```
Dir {  ArchiveDir "/var/www/repository" };  
BinDirectory "dists/custom/main/binary-i386" {  
  Packages "dists/custom/main/binary-i386/Packages";  
  Contents "dists/custom/Contents-i386"; 
};  
Tree "dists/custom" {  
  Sections "main";  
  Architectures "i386"; 
};
```

Die Datei /etc/apt/apt-custom-release.conf muss ähnlich aussehen:

```
APT::FTPArchive::Release::Origin "eigenes-repo"; 
APT::FTPArchive::Release::Label "eigenes-repo"; 
APT::FTPArchive::Release::Suite "custom"; 
APT::FTPArchive::Release::Codename "custom"; 
APT::FTPArchive::Release::Architectures "i386"; 
APT::FTPArchive::Release::Components "main"; 
APT::FTPArchive::Release::Description "Eigene Pakete";
```

Folgende Befehle müssen abgesetzt werden, um das custom-repository zu
bauen:

```
root@host #] apt-ftparchive generate /etc/apt/apt-ftparchive-custom.conf 
root@host #] apt-ftparchive -c /etc/apt/apt-custom-release.conf release /var/www/repository/dists/custom/ > /var/www/repository/dists/custom/Release
```

Es muss auf den Clients nur folgende Zeile an die
`/etc/apt/sources.list` angehängt werden:

```
deb http://server/repository custom main
```

*Hinweis:* Wenn Sie das jetzt so testen, werden Sie sehen, dass das
Paket nicht authentifiziert werden kann. Das liegt daran, dass das
Repository nicht signiert ist. Dies ist aber Inhalt [eines eigenen Artikels](/doku.php/wiki:old:apt-repository-mit-gpg-signieren "wiki:old:apt-repository-mit-gpg-signieren").

Nach dem Signieren des Repositories müssen folgende Befehle ausgeführt
werden:

```
root@agent #] wget http://server/repository/repo.key 
root@agent #] apt-key add repo.key
```
