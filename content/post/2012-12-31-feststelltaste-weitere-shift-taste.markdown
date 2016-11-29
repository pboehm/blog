+++

tags = ["tuxorials", "german"]
layout = "post"
title = "Feststelltaste = weitere SHIFT-Taste"
date = "2012-12-31"

+++

>
> Dieser Artikel wurde von [tuxorials.de](http://tuxorials.de) (Dokuwiki) hierher migriert!
> Mögliche Darstellungsfehler bitte ich zu entschuldigen.
>


Wenn Sie sich auch über die, in meinen Augen sinnlose, Feststelltaste
(CAPS LOCK) ärgern, weil sie immer dann gedrückt wird, wenn sie es nicht
soll, gibt es unter Linux eine ganz einfache Möglichkeit dieser Taste
ihre Funktion zu nehmen. Ich konnte immer eine weitere SHIFT-Taste
gebrauchen und so habe ich der Feststelltaste die Funktion einer
SHIFT-Taste zugewiesen.

Um das zu tun legen Sie eine Datei mit dem Namen .Xmodmap in Ihrem
Home-Verzeichnis an, wenn Sie nicht schon existiert. Geben Sie nun die
drei folgenden Zeilen ein und speichern Sie die Datei.

```
keycode 66 = Caps_Lock 
remove Lock = Caps_Lock 
add Shift = Caps_Lock
```

Nach einem erneuten Anmelden wird Ihnen in einem Fenster angeboten eine
modmap-Datei zu laden und deren Inhalt anzuwenden. Klicken Sie dafür die
Datei an und danach auf den Button „Laden“.
