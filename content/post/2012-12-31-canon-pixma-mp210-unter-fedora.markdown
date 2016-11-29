+++

tags = ["tuxorials", "german"]
layout = "post"
title = "Canon Pixma MP210 unter Fedora"
date = "2012-12-31"

+++

>
> Dieser Artikel wurde von [tuxorials.de](http://tuxorials.de) (Dokuwiki) hierher migriert!
> Mögliche Darstellungsfehler bitte ich zu entschuldigen.
>


Auch wenn ich in der vorigen Fassung dieses Beitrags geschrieben habe,
dass es für den PIXMA MP210 keinen Open-Source-Treiber gibt, habe ich
doch noch eine weitere Möglichkeit gefunden, ohne den
Hersteller-Treiber, den Drucker zum Arbeiten zu überreden.

  Das Gutenprint-Projekt hat für das Nachfolgermodell, den PIXMA MP220,
einen offenen Treiber in Form einer PPD-Datei erstellt. Die PPDs des
Gutenprint-Projekts werden in Form zweier Pakete ausgeliefert und sind
standardmäßig unter Fedora und auch allen anderen
Mainstream-Distributionen installiert.

Sollten die Pakete in Ihrem System nicht installiert sein, müssen Sie
sie durch folgenden Befehl nachinstallieren (distributionsabhängig):

```
root@host ]# yum install gutenprint*
```

Im Vergleich zur Canon-PPD bietet die freie PPD wesentlich mehr
Funktionen (Graustufendruck …) und eine erheblich bessere Druckqualität.
Ihren Drucker können Sie nun über die üblichen Wege konfigurieren
(CUPS-Webinterface, `system-config-printer`).
