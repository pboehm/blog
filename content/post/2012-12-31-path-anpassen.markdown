+++

tags = ["tuxorials", "german"]
layout = "post"
title = "$PATH anpassen"
date = "2012-12-31"

+++

>
> Dieser Artikel wurde von [tuxorials.de](http://tuxorials.de) (Dokuwiki) hierher migriert!
> Mögliche Darstellungsfehler bitte ich zu entschuldigen.
>


Die Shell-Variable `$PATH` ist dafür zuständig, Pfade zu Verzeichnissen
festzulegen, in denen die Shell nach ausführbaren Dateien sucht und sie
so in der Lage ist, diese Dateien ohne explizite Pfadangabe auszuführen.
Standardmäßig sind dort alle wichtigen Verzeichnisse wie `/bin`,
`/usr/bin`, `/usr/local/bin`, `/sbin` oder `/usr/sbin` enthalten, sodass
es möglich ist, die Programme `cat` oder `grep` ohne Pfadanagbe
auszuführen. Manchmal ist es aber notwendig andere Pfade hinzuzufügen,
um eigene Programme oder Scripts genauso komfortabel ausführen zu
können. Die Anpassung wird nachfolgend dargestellt.

Um diese Variable dauerhaft ändern zu können, muss man wissen, welche
Dateien beim Start eines Linux-Systems ausgelesen und interpretiert
werden.

*HINWEIS* Die hier beschriebene Vorgehensweise bezieht sich auf die
Standard-Shell `bash` (Bourne-Again-Shell), bei anderen Shells wie der
`csh`, `tcsh` oder der `zsh` ist dieses Vorgehen anders und es gibt
andere Dateien, aber da diese Shells sehr selten sind, lasse ich die
jetzt ganz dreist außen vor.

*/etc/bashrc oder unter Debain/Ubuntu /etc/bash.bashrc*

Diese Dateien sind global und somit hat dort nur `root` Schreibzugriff,
d.h. alles was hier festgelegt wird, gilt für alle Nutzer des Sytems und
es ist sehr einfach und komfortabel durch diese Datei Rahmenbedingung
für die Nutzer festzulegen. Wenn Sie als normaler Nutzer auf einem
System mit mehreren Nutzern arbeiten, wird es Ihnen normalerweise nicht
möglich sein, in der globalen Datei etwas zu ändern und somit verbleiben
Ihnen noch die lokalen Dateien.

*Beispiel:* Stellen Sie sich vor, dass Sie in Ihrem Homeverzeichnis
einen Ordner `Scripts` und einen Ordner `Programs` haben, indem Sie Ihre
eigenen Programmierprojekte und Shell-Scripte aufbewahren, die jeweils
alle ausführbar sind. Sie möchten diese aber wie ganz normale Programme
(`cat`, `less` oder` grep`) ohne Pfad-Angabe ausführen. Um das zu
erledigen fügen Sie der Datei `/etc/bashrc` oder `/etc/bash.bashrc`
(Debian/Ubuntu) folgende Zeilen hinzu:

```
#Erweiterung der PATH-Variable 
PATH=$PATH:/home/philipp/Scripts:/home/philipp/Programs 
export $PATH
```

*Erklärung:* Die erste Zeile bildet nur einen Kommentar, der Ihnen beim
erneuten Aufsuchen der Stelle in der Datei behilflich sein kann. Die
zweite Zeile bedeutet wörtlich: Lege Eine Variable mit dem Namen `PATH`
an, fülle sie mit dem Wert aus der, schon existierenden, `PATH`-Variable
und hänge durch einen Doppelpunkt (wichtig!!!) separiert neue Pfade an.
Die `export`-Anweisung in der dritten Zeile bedeutet nur, dass diese
Variable auch an die Subshells weitergegeben wird und somit zum Beispiel
auf in Shellscripten zur Verfügung steht, weil bei deren Aufruf eine
neue Subshell gestartet wird.

*\~/.bashrc oder mit voller Pfadangabe /home/user/.bashrc* Diese Datei
existiert für jeden Benutzer und jeder Benutzer kann sie seinen Wünschen
entsprechend editieren. Sie befindet sich direkt in Ihrem
Homeverzeichnis und um dort Verzeichnisse zu PATH hinzuzufügen, gehen
Sie wie bei der globalen `bashrc` vor.
