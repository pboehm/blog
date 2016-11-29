+++

tags = ["tuxorials", "german"]
layout = "post"
title = "ssh: Client-spezifische Konfiguration"
date = "2012-12-31"

+++

>
> Dieser Artikel wurde von [tuxorials.de](http://tuxorials.de) (Dokuwiki) hierher migriert!
> Mögliche Darstellungsfehler bitte ich zu entschuldigen.
>


Dieser Beitrag soll die Möglichkeit der Client-Konfiguration bei `ssh`
aufzeigen. Man kann dadurch häufig auftretende Befehle extrem verkürzen
und spezifische Einstellungen festlegen.

Als Client bezeichnet man das Programm, mit dem die Verbindung zu einem
entfernten SSH-Server herstellt. Für die Konfiguration dieses Clients
gibt es drei verschiedene Möglichkeiten die nachfolgend, absteigend in
ihrer Wichtung, dargestellt sind:

1.  **Kommandozeilen-Optionen** (haben die höchste Wichtung und sind für
    temporäre Änderungen geeignet)
2.  **Nutzer-spezifische Konfigurationsdateien**
3.  **Systemweite Konfiguration**

Wenn eine Direktive mehrfach gesetzt wird, wird immer der erste
auftretende Wert übernommen. Wenn der Systemadministrator systemweit die
Kompression für die SSH-Verbindung aktiviert, der Nutzer dieses Feature
jedoch deaktiviert, bleibt die Funktion ausgeschaltet.

Jeder Nutzer kann im Verzeichnis `~/.ssh/` eine Datei `config`
erstellen, die die Konfiguration enthält. Wie bei allen
sicherheitskritischen Dateien müssen auch hier die Zugriffsrechte
ordnungsmäßig gesetzt werden (`chmod 600 .ssh/config`).

Die nachfolgenden Direktiven erlauben einen einfachen Zugriff auf den
Host `realtesthost`.

```
Host test  
HostName realtesthost.example.com  
Port 31245  
User smith
```

Dieser Konfiguration würde der der folgende Befehl entsprechen:

```
you@host]$ ssh -p31245 smith@realtesthost.example.com
```

hingegen mit der Konfiguration:

```
you@host]$ ssh test
```

Über die möglichen Konfigurationsdirektiven informiert der Befehl man
ssh\_config und bei Fehlern im Aufbau der Verbindung hilft die
Kommandozeilenoption -v, sodass Statusinformationen und auch
Fehlermeldungen ausgegeben werden.
