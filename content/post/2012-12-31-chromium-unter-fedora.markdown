+++

tags = ["tuxorials", "german"]
layout = "post"
title = "Chromium unter Fedora"
date = "2012-12-31"

+++

>
> Dieser Artikel wurde von [tuxorials.de](http://tuxorials.de) (Dokuwiki) hierher migriert!
> Mögliche Darstellungsfehler bitte ich zu entschuldigen.
>


Die Open-Source-Variante von Googles Browser Chrome mit dem Namen
Chromium ist selbst nur im Quellcode verfügbar und muss deswegen selbst
kompiliert werden. Da dies ziemlich aufwendig und nicht ganz trivial
ist, gibt es für die meisten Distributionen sogenannte Binärpakete, wo
jemand Chromium bereits übersetzt und an die distributionsspezifischen
Besonderheiten angepasst hat. Den Vorgang für Fedora und einige weitere
nützliche Infos erklärt dieser Beitrag.

Um Chromium als Paket installieren zu können, muss ein weiteres
Repository in das Verzeichnis `/etc/yum.repos.d/` eingetragen werden.
Das Repository wird von einem RedHat-Mitarbeiter namens Tom Callaway
verwaltet und auch regelmäßig aktualisiert. Durch die hohe Frequenz an
Veröffentlichung von neuen Chromium-Versionen stehen hier auch fast
wöchentlich neue Versionen zum Update bereit.

Laden Sie die folgende Datei herunter und platzieren Sie sie unter
`/etc/yum.repos.d/`:

```
http://repos.fedorapeople.org/repos/spot/chromium/fedora-chromium.repo
```

Geben Sie nun folgenden Befehl ein, um Chromium zu installieren:

```
root@host #] yum install chromium
```

Danach finden Sie im Gnome-Menü, im Abschnitt Internet, den Eintrag
Chromium-Browser, über den Sie den Browser starten können. Um Chromium
zu konfigurieren klicken Sie auf dem Button mit dem Schraubenschlüssel
und dann auf Optionen. Dort können Sie z.B. einstellen, dass Chromium
wie eine native GTK-Anwendung aussieht und sich dadurch besonders gut in
den Fedora-Desktop integriert. Ebenfalls zu Empfehlen sind die
Erweiterungen `AdBlock` und `FlashBlock`, welche sich über den
Menüeintrag Erweiterungen installieren lassen.

User-Agent umstellen
++++++++++++++++++--

Ein interessantes Feature an Chromium und auch den meisten anderen
Browsern ist, dass sie sich als „jemand Anderes“ ausgeben können. Auch
wenn man über das iPad gespaltener Meinung sein kann, fördert es die
Verbreitung von Videos, die per HTML5-Videotag in die Webseiten
eingebunden werden. Dies ist eine exzellente Bewegung, was die
ungeliebte Technik namens Flash überflüssig machen wird. Nun bieten
einige Anbieter spezielle Seiten für das iPad an und unterscheiden das
mit Hilfe des User-Agents, mit welchem sich das iPad den Webservern
bekannt macht. Um nun die Videos ebenfalls direkt im Browser zu rendern,
muss der User-Agent von Chromium geändert werden.

*User-Agent des iPads (nicht aktuell):*

```
Mozilla/5.0 (iPad; U; CPU OS 3_2 like Mac OS X; en-us) AppleWebKit/531.21.10 (KHTML, like Gecko) Version/4.0.4 Mobile/7B334b Safari/531.21.10
```

Wenn man Chromium nun mit der Option `-user-agent` gefolgt von der
Zeichenkette des iPads aufruft, gibt sich Chromium als iPad der ersten
Generation aus.

```
you@host $] chromium-browser -user-agent="Mozilla/5.0 (iPad; U; CPU OS 3_2 like Mac OS X; en-us) AppleWebKit/531.21.10 (KHTML, like Gecko) Version/4.0.4 Mobile/7B334b Safari/531.21.10"
```

Eine weitere Option wäre `–incognito`, die Chromium direkt im
Inkognito-Modus startet, wo keine Statistiken oder besuchten Seiten
gespeichert werden.
