+++
layout = "post"
title = "Szenario 1: einfaches File-Sharing mit Windows-Clients"
date = "2012-12-31"

+++

>
> Dieser Artikel wurde von [tuxorials.de](http://tuxorials.de) (Dokuwiki) hierher migriert!
> Mögliche Darstellungsfehler bitte ich zu entschuldigen.
>


In der ersten Episode der Mini-Serie, zur Konfiguration von Samba, geht
es um den einfachen Austausch von Daten ohne jeglische
Benutzerbeschränkung.

**Das Szenario:** Es soll einfach möglich sein, Filme und Musik für
Freunde in einem normal geswitchten Netzwerk bereitzustellen, ohne, dass
es Features wie Drucker-Sharing oder Home-Verzeichnisse für Nutzer gibt.
Ebenfalls soll es eine Möglichkeit geben, dass Leute Ihnen neue
Downloads zugänglich machen bzw. sie auf Ihren Server kopieren können.

*Die /etc/samba/smb.conf-Datei*

```
[global]
workgroup = WORKGROUP  
server string = Fedora 11 - Samba Server  
log file = /var/log/samba/log.%m  
max log size = 50  
os level = 64  
security = user  
map to guest = bad user  
passdb backend = tdbsam  
encrypt passwords = yes  
guest account = nobody  
guest ok = yes

[Filme]
path = /media/Daten/Filme 
browseable = yes 
guest only = yes 
read only = yes 
comment = Filme

[Musik]
path = /media/Daten/Musik 
browseable = yes 
guest only = yes 
read only = yes 
comment = Musik

[Downloads]
path = /media/Daten/Downloads  
browseable = yes  
guest only = yes 
writeable = yes  
comment = Downloads
```

  **HINWEIS** Falls Sie Probleme damit haben sollten, dass Ihre Nutzer
auf Ordner in der Freigabe nicht zugreifen können, liegt das
warscheinlich daran, dass bei dem Ordner im Bereich Others zu niedrige
Rechte eingestellt sind. Entweder setzen Sie den guest account auf Ihren
account, sodass Ihre Nutzer die selben Zugriffsrechte haben, wie Sie
oder Sie ändern die Zugriffsrechte auf den Ordner mit folgendem
Kommando:

```
you@host ]$ chmod -R 774 /media/Daten/Downloads
```
