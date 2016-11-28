+++
layout = "post"
title = "Beiträge in DokuWiki mit vim schreiben"
date = "2012-12-31"

+++

>
> Dieser Artikel wurde von [tuxorials.de](http://tuxorials.de) (Dokuwiki) hierher migriert!
> Mögliche Darstellungsfehler bitte ich zu entschuldigen.
>


[DokuWiki](http://dokuwiki.org "http://dokuwiki.org") bietet selbst
eigentlich eine recht angenehme Art, technische Dokumentationen online
zu schreiben, wobei natürlich nichts einen klassischen Offline-Editor
schlagen kann. Deswegen war ich doch sehr erfreut, als ich das Plugin
[DokuVimKi](https://github.com/chimeric/dokuvimki "https://github.com/chimeric/dokuvimki")
für den populären Editor [Vim](http://vim.org "http://vim.org") entdeckt
habe. Durch dieses Plugin wird der Workflow von DokuWiki in den
Vim-Editor integriert und ermöglicht somit ein komfortables
Erstellen/Bearbeiten/Verwalten von DokuWiki-Beiträgen. Die Einrichtung
des Plugins beschreibt dieser Beitrag

Installation der notwendigen Komponenten
+++++++++++++++++++++++++++++++++++++++-

Um DokuVimKi zu installieren, muss man sich das Plugin bei
[github](http://github.com "http://github.com") auschecken, wofür
[git](http://git-scm.com/ "http://git-scm.com/") installiert sein muss.
Führen Sie folgenden Befehl aus und es befindet sich dann ein
Verzeichnis `dokuvimki` im aktuellen Verzeichnis, das den Plugin-Code
enthält.

```
git clone https://github.com/chimeric/dokuvimki.git
```

Alternativ kann auch das folgende [Tar-Archiv heruntergeladen](http://www.vim.org/scripts/download_script.php?src_id=13501 "http://www.vim.org/scripts/download_script.php?src_id=13501")
und entpackt werden. Dann müssen die Ordner `doc`, `plugin` und `syntax`
in das Verzeichnis `~/.vim/` verschoben werden.

DokuVimKi benötigt zu Kommunikation mit DokuWiki eine bestimmte
Python-Library, welche ebenfalls bei github ausgecheckt werden kann.
Nachfolgend muss diese Library dann im System installiert werden.

```
git clone https://github.com/chimeric/dokuwikixmlrpc
cd dokuwikixmlrpc
sudo python setup.py install
```

Damit wären die notwendigen Komponenten installiert, fehlt nur noch die
Konfiguration.

Konfiguration von DokuWiki
++++++++++++++++++++++++--

Der Zugriff per XML-RPC ist bei DokuWiki standardmäßig deaktiviert, was
für den Zugriff durch DokuVimKi aber geändert werden muss.

Melden Sie sich im Admin-Interface bei DokuWiki an und suchen Sie im
Abschnitt `Authentifizierungs-Konfiguration` nach
`XML-RPC-Zugriff erlauben` und aktivieren Sie die zugehörige Checkbox.
Tragen Sie Ihren Nutzernamen noch in das darauffolgende Textfeld ein und
speichern Sie die Änderungen.

Konfiguration von vim
+++++++++++++++++++++

Als letzter Ort für die Konfiguration bleibt vim selbst, welcher noch
vom DokuVimKi-Plugin erfahren muss. Es müssen folgende Zeilen in die
`~/.vimrc` integriert werden, wobei die Werte für Nutzername, Passwort
und URL angepasst werden müssen:

```
let g:DokuVimKi_USER="IHR_NUTZERNAME_IM_DOKUWIKI"
let g:DokuVimKi_PASS="IHR_PASSWORT_IM_DOKUWIKI"
let g:DokuVimKi_URL="http://<YOUR_DW_LOCATION>/lib/exe/xmlrpc.php"
```

Nutzung von DokuVimKi
+++++++++++++++++++++

Öffnen Sie Vim durch Eingabe von `vim` oder auch manchmal `vi`. Wenn Sie
eine fehlerhafte `.vimrc` haben sollten, wird Ihnen das vim nun sagen.
Das Plugin wird nicht direkt beim Start geladen, was auch nicht sinnvoll
wäre. Geben Sie somit folgenden Befehl im normalen Modus ein:

```
:DokuVimKi
```

Nach einer kurzen Wartezeit für das Login, stehen die Funktionen zum
Bearbeiten von Seiten zur Verfügung.

 Befehl                | Bedeutung
 +++++++++++++++++++++ | ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 :DWedit \<page\>      | Öffne die angegebene Datei zum Schreiben oder lege sie an
 :DWsave \<summary\>   | Speichere die Änderungen mit optionaler Zusammenfassung
 :DWclose              | Schließe die aktuelle Datei und gib sie für Änderungen frei

Bei den dargestellten Befehlen handelt es nur um eine kleine Auswahl,
die komplette Dokumentation erhält man durch die Eingabe von
`:help dokuvimki`. Nachfolgend werden noch einige Shortcuts zum
schnellen Schreiben von Beiträgen dargestellt, wobei diese jeweils im
INSERT-Modus eingegeben werden.

 Shortcut              | Bedeutung
 +++++++++++++++++++++ | ++++++++++++++++++++++++++++++++++++++++++++++++
 STRG-D + STRG-H       | Fügt eine Überschrift ein
 STRG-D + STRG-L       | Fügt das Konstrukt für einen Link ein
 STRG-D + STRG-[BIU]   | Formatiere **fett**, *kursiv*, *unterstrichen*
 STRG-D + STRG-[KF]    | Füge einen Code- [K] oder Datei-Block [F] ein
