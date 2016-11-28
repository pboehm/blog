+++
layout = "post"
title = "ssh: PublicKey-Authentifizierung"
date = "2012-12-31"

+++

>
> Dieser Artikel wurde von [tuxorials.de](http://tuxorials.de) (Dokuwiki) hierher migriert!
> Mögliche Darstellungsfehler bitte ich zu entschuldigen.
>


Wenn Sie sich oft per SSH auf einen entfernten Host anmelden, haben Sie
vielleicht das Bedürfnis die Passwortabfrage beim Verbinden zu umgehen.
Dieser Artikel beschreibt den Vorgang der Authentifizierung mit Hilfe
eines Public Key, was keine Passworteingabe erfordert.

Ich gehe davon aus, dass auf Ihrem Host die ssh-Pakete vorhanden sind.
Wenn nicht installieren Sie sie bitte nach. Der erste Schritt zum
passwortfreien Zugriff ist die Erzeugung eines Schlüsselpaars, wobei der
sogenannte Private Key (privater Schlüssel) schützenswert ist und auch
nicht aus der Hand gegeben werden sollte. Das Pendant dazu ist der
Public Key (öffentlicher Schlüssel), welcher auf den entfernten Host
übertragen und in eine spezielle Datei geschrieben werden muss. Diese
beiden Schlüssel stehen in einer mathematischen Beziehung, denn der
Public Key kann aus dem Private Key berechnet werden und zum
Authentifizieren werden beide Schlüssel herbeigezogen.

### Schlüsselpaar erstellen

Zum Erstellen des Schlüsselpaars wird der Befehl `ssh-keygen` genutzt,
welcher nach einer Passphrase verlangt. Jetzt muss man sich entscheiden,
mit einer Passphrase ist das Schlüsselpaar gesichert, jedoch muss diese
Passphrase bei der Benutzung des Schlüsselpaars erst eingegeben werden.
Im ersten Moment mindert das den Komfort, jedoch haben die
Desktopsysteme wie Gnome oder KDE Mechanismen entwickelt, die das
Schlüsselpaar automatisch aktivieren können. In einer nativen
Textkonsole ist man denn aber doch zur Eingabe gezwungen.

Wenn man eine leere Eingabe tätigt, wird keine Passphrase gesetzt. Die
Keys werden standardmäßig im Verzeichnis `~/.ssh` gespeichert. Die Datei
`id_rsa` beinhaltet den privaten Schlüssel und dementsprechend sollte
diese Datei geschützt werden, was schon mit dem Setzen der
Zugriffsrechte beginnt (`chmod 0600 id_rsa`). Wie nicht anders zu
erwarten liegt dann in der Datei `id_rsa.pub` der öffentliche Schlüssel,
welcher auf die entfernten Rechner übertragen werden muss.

```
user@host:~$ ssh-keygen  
Generating public/private rsa key pair. 
Enter file in which to save the key (/home/username/.ssh/id_rsa):  
Created directory /home/username/.ssh. 
Enter passphrase (empty for no passphrase):  
Enter same passphrase again:  
Your identification has been saved in /home/username/.ssh/id_rsa. 
Your public key has been saved in /home/username/.ssh/id_rsa.pub. 
The key fingerprint is: 3e:72:b5:e5:0c:ec:9e:69:2d:bd:46:6f:90:af:2c:02 username@host 
The keys randomart image is: .....
```

### Einrichtung der Authentifizierung

Nun muss der PublicKey auf den entfernten Rechner übertragen werden, was
am sichersten per `scp` geschieht. Der nachfolgende Befehl kopiert den
Public Key auf den Host testhost.example.org in das Verzeichnis
`/home/otheruser`:

```
you@host :~$ scp .ssh/id_rsa.pub otheruser@testhost.example.org:/home/otheruser
```

Nach der Eingabe des Passworts wird die Datei übertragen und Sie müssen
sich jetzt direkt per `ssh` am entfernten Host anmelden, was mit
folgendem Befehl geschieht:

```
you@host :~$ ssh otheruser@testhost.example.org
```

Ebenfalls nach der Eingabe des Passworts sind Sie auf dem entfernten
Host angemeldet und müssen nachfolgend das Hinzufügen des Schlüssels
bewerkstelligen. Legen Sie in `.ssh` eine Datei namens `authorized_keys`
an (Wenn nötig muss .ssh erstellt werden) und wechseln Sie die
Zugriffsrechte der Datei auf `0600`. Hängen Sie nachfolgend den
PublicKey an diese Datei an. Die nachfolgenden Befehle tun genau das:

```
otheruser@otherhost :~$ mkdir .ssh
otheruser@otherhost :~$ touch .ssh/authorized_keys
otheruser@otherhost :~$ chmod 0600 .ssh/authorized_keys
otheruser@otherhost :~$ cat id_rsa.pub >> .ssh/authorized_keys 
otheruser@otherhost :~$ rm id_rsa.pub
```

Wenn Sie sich jetzt erneut per `ssh` mit dem Nutzer otheruser am Host
testhost.example.org anmelden, müssten Sie ohne Passworteingabe Zugriff
erlangen. Falls Sie dennoch nach einem Passwort gefragt werden, sollten
Sie den ssh-Dienst auf testhost neustarten und in die entsprechenden
Log-Dateien (`/var/log/messages`, `/var/log/secure`, `/var/log/syslog`)
schauen. Meistens sind es falsch gesetzte Zugriffsrechte die den Vorgang
dann fehlschlagen lassen, was aber aus den Log-Dateien ersichtlich ist.

**Achtung:** In der hier vorgestellten Konfiguration ist der Login
nutzerspezifisch, was bedeutet, dass man sich nur als der Nutzer
anmelden kann, bei dem auch der Public Key hinterlegt ist. Notfalls muss
der Public Key weiteren Nutzer zugänglich gemacht werden.
