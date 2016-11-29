+++

tags = ["tuxorials", "german"]
layout = "post"
title = "Gnome Shell friert durch Anstecken von externen Monitor ein"
date = "2012-12-31"

+++

>
> Dieser Artikel wurde von [tuxorials.de](http://tuxorials.de) (Dokuwiki) hierher migriert!
> Mögliche Darstellungsfehler bitte ich zu entschuldigen.
>


Nachdem ich [Fedora
15](http://fedoraproject.org "http://fedoraproject.org") mit Gnome 3 auf
meinem Netbook *(Samsung N130)* und auch meinem größeren Notebook
installiert hatte, war ich von den grafischen Effekten der Gnome Shell
doch sehr angetan, alles lief flüssig auch unter Last. Nun wollte ich
doch einen externen Monitor anschließen, weil das Arbeiten mit einem
erweiterten Desktop doch sehr komfortabel ist. Das Problem lag nun aber
darin, dass die Gnome Shell regelrecht einfror und auf Klicks erst nach
einer Zeit von mehreren Sekunden reagiert und die Auslastung der Rechner
erheblich anstieg. Die Lösung für dieses Problem beschreibt dieser
Artikel.

Nachdem ich einen
[Bugreport](https://bugzilla.redhat.com/show_bug.cgi?id=704764 "https://bugzilla.redhat.com/show_bug.cgi?id=704764")
im [Redhat](http://redhat.com "http://redhat.com") Bugzilla geschrieben
hatte, kam eine ernüchternde Antwort von einem Entwickler, der das
Problem als Hardwareproblem oder eher Hardwareeinschränkung
identifizierte. In beiden Geräten stecken Displaycontroller von Intel,
was ein `lspci` diagnostizierte.

```
00:02.1 Display controller: Intel Corporation Mobile 945GM/GMS/GME, 943/940GML Express Integrated Graphics Controller (rev 03)
```

Bei dieser Hardware gibt es eine Grenze bei der Auflösung von 2048 Pixel
in der Breite, bei der die Grafikhardware hardwarebschleunigt arbeiten
kann. Die Gnome Shell setzt für die grafischen Effekte jedoch
Hardwarebeschleunigung voraus, weshalb die Gnome Shell beim Anstecken
des Monitors extrem langsam wurde. Die Auflösung von meinem Notebook
(1280×800) und dem externen Monitor (1280×1024) lagen in der
Horizontalen also über der Grenze von 2048 Pixel und hatten deswegen
keine Hardwarebeschleunigung mehr.

Die Lösung dieses Problems liegt darin, bei angesteckten Monitor in den
Rückfallmodus von Gnome 3 zu wechseln, was mit Funktionseinbußen einher
geht oder im Beschränken der Monitorauflösung auf einen passenden wert.
Im Falle meines Netbooks ist dies mit 1024×768 möglich, bei meinem
Notebook hieße das aber eine Auflösung geringer als 800×600, was ich mir
jedoch nicht zumuten möchte. Wäre der Monitor beim Booten des Notebooks
bereits angesteckt gewesen, wäre Gnome 3 automatisch in den
Rückfallmodus gewechselt, jedenfalls besagt das der Bugreport.
