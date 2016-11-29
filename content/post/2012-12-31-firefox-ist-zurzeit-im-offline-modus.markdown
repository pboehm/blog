+++

tags = ["tuxorials", "german"]
layout = "post"
title = "Firefox ist zurzeit im Offline-Modus"
date = "2012-12-31"

+++

>
> Dieser Artikel wurde von [tuxorials.de](http://tuxorials.de) (Dokuwiki) hierher migriert!
> Mögliche Darstellungsfehler bitte ich zu entschuldigen.
>


So oder so ähnlich klingt der Hinweis von Firefox, wenn man ihn startet,
ohne eine Internetverbindung zu haben. Dieses Verhalten ist spezifisch
für Linux, da Firefox dort den NetworkManager um den Status der
Internetkonnektivität befragt.

Und das Standardverhalten ist halt, dass Firefox dann den Hinweis mit
dem Offline-Modus zeigt, welchen man händisch mit einen Klick in
„Datei\\Offline arbeiten“ beseitigen kann. Dieses Nachfragen beim
NetworkManager kann man unterbinden, sodass einfach eine Fehlermeldung
angezeigt wird, dass die Startseite nicht erreichbar ist.

Um das Verhalten zu ändern, geben Sie in die Adresszeile von Firefox
about:config ein und bestätigen, dass Sie vorsichtig sein werden. Suchen
Sie nach dem Schlüssel toolkit.networkmanager.disable und setzen den
Wert mit einem Doppelklick auf true. Nun sollte das oben beschriebene
Verhalten eingestellt sein.
