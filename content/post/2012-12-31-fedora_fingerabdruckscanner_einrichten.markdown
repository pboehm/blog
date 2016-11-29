+++

tags = ["tuxorials", "german"]
layout = "post"
title = "Fedora: Fingerabdruckscanner einrichten"
date = "2012-12-31"

+++

>
> Dieser Artikel wurde von [tuxorials.de](http://tuxorials.de) (Dokuwiki) hierher migriert!
> Mögliche Darstellungsfehler bitte ich zu entschuldigen.
>


Wer in seinem Notebook einen Fingerabdruckscanner eingebaut hat, der
kann unter Linux und unter Fedora im Speziellen damit den Login-Vorgang
erheblich beschleun igen, indem er seine Finger auf den Scanner legt
anstatt mit ihnen das Passwort eingibt. Unter Linux bietet das Tool
`fprintd` die nötigen Funktionalitäten (darunter auch ein entsprechendes
PAM-Modul) und ist z.B. auch in `gdm` integriert.

Das einzige was unter einem aktuellen Fedora eingerichtet werden muss,
ist der Finger und dies geschieht durch Aufruf des Tools
`fprintd-enroll`, welches mehrmals dazu auffordert, den Finger über den
Scanner zu ziehen. Wenn dies geschehen ist, erscheint bei Fedora 16,
unter dem Feld zur Passworteingabe nun der Hinweis, dass nun der Finger
aufgelegt werden soll. Ebenfalls lässt sich jetzt der Bildschirm mit
Hilfe des Fingerabdrucks entsperren sowie das Ausführen von Programmen
mit `sudo` ohne Passworteingabe durchführen.

Ein Problem besteht bei der Nutzung des Fingerabdruckscanners aber,
nämlich dass der „Schlüsselbund“ von Gnome (`gnome-keyring`) nicht
entsperrt wird, sodass bei Benutzung des Schlüsselbundes eine
Passwortabfrage erscheint. Jetzt muss man abwägen, ob man die
Verschlüsselung des Keyrings entfernt oder jedes Mal das Passwort
eingibt.
