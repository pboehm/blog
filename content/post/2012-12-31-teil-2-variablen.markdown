+++

tags = ["tuxorials", "german"]
layout = "post"
title = "Teil 2: Variablen"
date = "2012-12-31"

+++

>
> Dieser Artikel wurde von [tuxorials.de](http://tuxorials.de) (Dokuwiki) hierher migriert!
> Mögliche Darstellungsfehler bitte ich zu entschuldigen.
>


Wie auch in anderen etablierten Programmiersprachen gibt es das
Paradigma der Variablen, welche grundsätzlich als Datenspeicher
herhalten müssen und deswegen auch in der Shell-Programmierung einen
hohen Stellwert haben.

Einer Variablen einen Wert zuweisen:

```
variable=wert
```

z.B

```
PATH=/bin/
```

*Zugriff auf den Wert einer Variable:* Auf den Wert einer Variablen kann
auch zwei Arten zugegriffen werden, wobei sie sich nur dadurch
unterscheiden, dass die eine Möglichkeit eine Begrenzung des
Variablennamens ermöglicht, was bei der String-Verkettung manchmal nötig
ist.

```
$Variable oder ${Variable}
```

Das folgende Beispiel zeigt die Verwendung von Variablen in
verschiedenen Möglichkeiten.

```
var1=a 
var2=${var1}b 
echo $var2 
path=/home/test/Desktop/testfile 
mv $path /dev/null
```

*Variablen an Subshells übergeben:* Normalerweise ist die Variable nur
in der aktuellen Shell gültig, was bedeutet, dass die Variable var1 nach
einem Aufruf von `bash` oder dem Starten eines Scriptes nicht den gleich
Wert hat, als wenn wir uns in der aktuellen Shell befinden, wo der
Variable der Wert zugewiesen wurde.

Mit dem Befehl `export` kann eine Variable ans Subshells übergeben
werden, sodass auch innerhalb von Shell-Scripten auf diese Variable
zugewiesen werden kann.

*Beispiel:*

```
var1="Dieser Text ist auch in Subshells erreichbar" 
export $var1 
bash 
echo $var1
```
