+++
layout = "post"
title = "Terminalausgaben formatieren"
date = "2012-12-31"

+++

>
> Dieser Artikel wurde von [tuxorials.de](http://tuxorials.de) (Dokuwiki) hierher migriert!
> Mögliche Darstellungsfehler bitte ich zu entschuldigen.
>


Wäre es nicht schön, in einem Shell-Script bestimmte Ausgaben
hervorzuheben oder sogar farbig auszugeben. Die Vorgehensweise und die
Fallstricke bei der formatierten Terminalausgabe erklärt dieser Beitrag.

Für die Formatierung innerhalb eines Terminals kann das Programm `tput`
verwendet werden, welches eine abstrakte Möglichkeit der Konfiguration
eines Terminals bietet. Es ist damit ebenfalls möglich, die Größe
(Zeilen, Spalten) eines Terminalfensters zu ermitteln. Dazu aber später
mehr.

*Verwendung* Die grundlegende Vorgehensweise beim Einsatz dieses Tools
ist die, dass vor einem bestimmten Text die Ausgabe mit Hilfe von `tput`
formatiert und nach dem Text wieder auf den Standard zurückgesetzt wird.
In Shell-Scripts bietet es sich deswegen an, die Formatierungen (Die
Ausgabe des tput-Befehls) in Variablen zu verfrachten, die dann beim
Aufruf eines echo-Befehls einfach mit ausgegeben werden. Dies ist nur
möglich, weil es sich bei den Formatierungen um bestimmte Steuerzeichen
für das Terminal handelt, die bei einer Weiterverarbeitung der Ausgaben
durch ein anderes Tool aber störend wirken könnten.

```
ft=`tput bold` 
rs=`tput sgr0` 
echo "${ft}Dieser Text ist fett${rs}"
```

Dieses kleine Beispiel zum Einstieg sollte eigentlich selbsterklärend
sein, jedoch möchte ich auf die verwendete Art des Zugriffs auf die
Variablen hinweisen. Der Einsatz der geschweiften Klammern ist hier
erforderlich, da durch das nicht vorhandene Leerzeichen zwischen dem
Text und der Variablen sonst keine Abgrenzung möglich wäre. Es ist
ebenfalls erforderlich, dass die doppelten Hochkommata verwendet werden,
weil sonst keine Ersetzung der Variablen durch ihren Wert vollzogen
würde.

Der wichtigste Befehl ist `tput sgr0`, welcher die Terminalformatierung
auf den Standard zurücksetzt.

*Farben* Wie schön wäre eine rote Farbe bei Fehlermeldungen oder
wichtigen Hinweisen. Die Beeinflussung der Farben geschieht mit Hilfe
von `tput setb` für den Hintergrund und `tput setf` für den Vordergrund.
Auf diese Befehle muss eine Zahl zwischen 0 und 7 folgen, die den
folgenden Farben entspricht.

-   0: Schwarz
-   1: Blau
-   2: Grün
-   3: Cyan
-   4: Rot
-   5: Magenta
-   6: Gelb
-   7: Weiß

```
tput setb 7
tput setf 2
```

Dies würde eine Farbkombination aus weißem Hintergund und grünen
Vordergrund hervorrufen.

*Formatierungen* Mit dem Befehl `tput bold` wird der Text fett und mit
`tput smul` unterstrichen ausgegeben.

```
und=`tput smul` 
ft=`tput bold` 
rs=`tput sgr0` 
echo "${ft}${und}Dies ist eine Überschrift, die fett und unterstrichen sein sollte${rs}"
```

*Informationen* Um z.B. die Größe des Terminalfensters zu ermitteln kann
man die beiden Befehle `tput cols` und `tput lines` einsetzen, wobei der
erste Befehl die Anzahl der Spalten (standardmäßig 80) und der zweite
die Zeilenanzahl (24) ausgibt.
