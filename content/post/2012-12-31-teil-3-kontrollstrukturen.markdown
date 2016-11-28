+++
layout = "post"
title = "Teil 3: Kontrollstrukturen"
date = "2012-12-31"

+++

>
> Dieser Artikel wurde von [tuxorials.de](http://tuxorials.de) (Dokuwiki) hierher migriert!
> Mögliche Darstellungsfehler bitte ich zu entschuldigen.
>


Wie gesagt, handelt es sich bei der Shell-Programmierung tatsächlich um
eine Art der Programmierung und deshalb muss es auch die sogenannten
Kontrollstrukturen geben, welche Inhalt dieses Beitrages sind.

### Die if-Anweisung

Die `if`-Anweisung ist die wichtigste aller Kontrollstrukturen und sie
nimmt auch in der Shell-Programmierung eine zentrale Rolle ein. Die
Anweisung ist eigentlich nur eine spezielle Syntax für das
`test`-Kommando und somit kann man für die Funktionen der `if`-Anweisung
die Manpage von `test` konsultieren.

Nachfolgend ist der grundlegende Aufbau der if-Anwesiung dargestellt:

```
if [[ Vergleich ]]
then 
  # Befehle
else 
  # Befehle, falls der Vergleich nicht zutrifft
fi
```

#### Vergleichsmöglichkeiten

Innerhalb der eckigen Klammern kann nach folgenden Mustern überprüft
werden, wobei sich die Muster an anderen echten Programmiersprachen
orientieren.

```
[[ $var1 > $var2 ]] oder [[ $var1 -gt $var2 ]]
```

In diesem Ausdruck wird überprüft ob Variable2 größer als Variable1 ist.
Dieses Muster kann auch mit `<` und `-lt` umgesetzt werden, wobei das
Verhalten sich entsprechend ändert.

```
[[ $var1 == $var2 ]] oder [[ $var1 -ne $var2 ]]
```

In diesem Ausdruck wird überprüft ob Variable2 identisch mit Variable1
ist. Dieses Muster kann auch mit `!=` und `-ne` umgesetzt werden, wobei
sich das Verhalten entsprechend ändert. Das test-Kommando bietet noch
einige interessantere Möglichkeiten, wobei die meisten unär sind, was
bedeutet, dass nur eine Variable an der Operation beteiligt ist.

```
[[ -e $var ]]  Gibt True zurück, wenn die Datei in $var existiert
[[ -b $var ]]  Gibt True zurück, wenn die Datei in $var existiert und ein Block-Device ist
[[ -c $var ]]  Gibt True zurück, wenn die Datei in $var existiert und ein Character-Device ist
[[ -d $var ]]  Gibt True zurück, wenn die Datei in $var existiert und ein Verzeichnis ist
[[ -b $var ]]  Gibt True zurück, wenn die Datei in $var existiert und ein Block-Device ist
[[ -L $var ]]  Gibt True zurück, wenn die Datei in $var existiert und es ein symbolischer Link ist
[[ -O $var ]]  Gibt True zurück, wenn die Datei in $var existiert und dem aktuellen Nutzer gehört
[[ -b $var ]]  Gibt True zurück, wenn die Datei in $var existiert und größer als 0 Byte ist
[[ -x $var ]]  Gibt True zurück, wenn die Datei in $var existiert und ausführbar ist
```

### die for-Schleife

Die `for`-Schleife ist eine Möglichkeit, einen Befehl für eine bestimmte
Anzahl oder für eine bestimmte Anzahl von Ereignissen auszuführen. So
gibt es auch die Möglichkeit über Dateien eines Verzeichnis zu iterieren
und dabei für jede Datei einen bestimmten Befehl auszuführen.
Nachfolgend ist der grundlegende Aufbau der if-Anwesiung dargestellt:

```
for var in Liste
do 
  # Befehle
done
```

Möglichkeiten der Liste:

-   `1 2 3 4 5` Bei dieser Liste würde bei jedem Schleifendurchlauf in
    der Variablen \$var erst der Wert 1 dann 2 und wie man sich sicher
    denken kann der Wert 3 sein. Das ist auch mit Wörtern möglich (eins
    zwei drei vier).
-   `` `Befehl` `` -&gt; Bei dieser Angabe wird über die Ausgabe des
    Befehls iteriert. Nachfolgendes Beispiel würde jede Datei aus dem
    `/tmp`-Verzeichnis in das `/dev/null` verschieben. Und nein, das
    `/dev/null` ist nicht das erste erkannte Sicherungslaufwerk, denn
    `/dev/null` ist das Datengrab.

```
for file in `ls /tmp`
do 
  mv $file /dev/null
done
```

#### C/C++/Java-ähnliche Syntax

In neueren Bash-Versionen ist eine Implementierung der C-ähnlichen
`for`-Schleife enthalten, welche eine Möglichkeit bietet, schnell und
ohne großen Schreibaufwand über einen großen Bereich von Zahlen zu
iterieren.

```
for (( i=1; ${i}&lt;=10; i++)); do  echo $i  done
```

Diese Schleife würde nacheinander die Werte 1-10 auf `stdout` ausgeben.

#### Steuerungsbefehle innerhalb der Schleife

-   `break` Der Befehl bricht die Schleife ab und führt das Programm
    nach der Schleife weiter
-   `continue` Der Befehl bricht den aktuellen Schleifendurchlauf ab
-   `exit` Der Befehl bricht innerhalb des gesamten Scripts die
    komplette Ausführung ab

### die switch-case-Anweisung

Bei der `switch-case`-Anweisung handelt es sich um ein Konstrukt,
welches einem sehr viel Schreibaufwand sparen kann, wenn man eine
Variable auf viele verschiedene Werte überprüfen muss und nicht für jede
Möglichkeit einen extra `if`-Block schreiben möchte.

Nachfolgend ist der grundlegende Aufbau der if-Anwesiung dargestellt:

```
case variable in 
  wert1)
    # Kommandos;; 
  wert2)  
    # Kommandos;; 
  *)
    # Kommandos;; 
esac
```

Das folgende Beispiel liest vom Nutzer einen Wert von der Tastatur ein
und reagiert darauf, mit bestimmten Befehlen:

```
read -p "Geben Sie eine Zahl zur Basis 2 ein" choice 
case choice in  
  32)  echo "Sie haben 32 eingegeben";;  
  64)  echo "Sie haben 64 eingegeben";; 
  *)  echo "Sie haben irgendetwas eingegeben";; 
esac
```

Ein Einsatzgebiet dieses Konstrukts ist die Parameterverarbeitung,
welche sicher auch noch einmal Thema eines Beitrag werden wird. Dies war
nun ein Beitrag über die wichtigsten Konstrukte für die Verzweigung und
Ablaufsteuerung innerhalb von Shell-Scripten.
