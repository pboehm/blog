+++

tags = ["tuxorials", "german"]
layout = "post"
title = "Gnome 3 an eigene Bedürfnisse anpassen"
date = "2012-12-31"

+++

>
> Dieser Artikel wurde von [tuxorials.de](http://tuxorials.de) (Dokuwiki) hierher migriert!
> Mögliche Darstellungsfehler bitte ich zu entschuldigen.
>


Das [3er Release des Gnome-Desktops](http://gnome3.org/ "http://gnome3.org/") bringt dem
Nutzer einen komplett umgekrempelten Desktop, welcher zahlreiche neue
Bedienkonzepte implementiert und damit auch mit alten Gewohnheiten aus
Zeiten von Gnome 2 Schluss macht. An einigen Stellen ging das Aufräumen
dann doch etwas zu weit, als Beispiel sei hier das Entfernen der
Funktion zum Verwalten von Dateien und Icons auf dem Desktop zu nennen.
Die altbekannten Applets aus Gnome 2 wurden entfernt und an ihre Stelle
treten die Gnome Shell Extensions, welche in Form von Javascript und CSS
tiefe Eingriffe in die Funktionalität der Gnome Shell erlauben. Dieser
Artikel stellt Möglichkeiten zum Anpassen von Gnome 3 vor und
präsentiert eine Auswahl an nützlichen Extensions, die einem z.B. das
System Monitor Applet zurückbringen.

Das Gnome Tweak Tool
++++++++++++++++++--

In den letzten Phasen der Entwicklung von Gnome 3 wurde einigen
Entwicklern wohl klar, dass einige Änderungen am Desktop wohl etwas zu
weit gehen und daraufhin begann die Entwicklung des 
[Gnome Tweak Tools](http://live.gnome.org/GnomeTweakTool "http://live.gnome.org/GnomeTweakTool"),
welches dem Desktop doch einige Funktionen verleihen, die dem Nutzer in
Gnome 2 doch sehr sinnvoll erschienen.

Das Gnome Tweak Tool erlaubt unter anderem folgende Anpassungen:

-   Ändern des verwendeten Desktop-Themes *(Standard: Adwaita)*
-   Ändern der im Desktop verwendeten Schriftarten/Schriftgrößen
-   Verhalten beim Schließen des Notebooks
-   Möglichkeit zum Verwalten von Dateien und Ordnern auf dem Desktop
-   Format der angezeigten Uhr *(Anzeige des Datums)*

Das Gnome-Tweak-Tool ist in allen Distributionen, die Gnome 3
ausliefern, als installierbares Paket enthalten. So installiert der
folgende Befehl das Tweak Tool unter Fedora 15:

```
# yum install gnome-tweak-tool
```

Gnome 3 hat standardmäßig zu breite Titelleisten!
++++++++++++++++++++++++++++++++++++++++++++++++-

Wenn einem die Titelleisten im Standard-Theme Adwaita von Gnome 3
übermäßig breit erscheinen und damit kostbaren Platz für Programme
verschwenden, gibt es dafür eine Lösung, welche zwar nicht wirklich
elegant ist, jedoch ihren Zweck erfüllt. Wie die Gnome Shell Extensions
ist auch das Aussehen der Gnome Shell durch CSS beeinflussbar, wobei man
beim Theme jedoch nicht mit dem nackten CSS Kontakt hat, sondern mit
einer XML-Datei, die das Aussehen des Themes beschreibt.

Wenn man das Standard-Theme Adwaita einsetzt, ist die entsprechende
XML-Datei folgende:

```
/usr/share/themes/Adwaita/metacity-1/metacity-theme-3.xml
```

Mit root-Rechten ausgestattet, kann man diese Datei bearbeiten und man
sollte die Eigenschaft `title_vertical_pad` von standardmäßig 13 auf
beispielsweise 6 verringern (Wahl des Autors). So sollte die folgende
Beschreibung eines normalen Fensters wie folgt aussehen:

```
<frame_geometry name="normal" title_scale="medium" rounded_top_left="4" rounded_top_right="4">
        <distance name="left_width" value="2" />   
        <distance name="right_width" value="2" />  
        <distance name="bottom_height" value="2" />
        <distance name="left_titlebar_edge" value="0"/> 
        <distance name="right_titlebar_edge" value="0"/>
        <distance name="title_vertical_pad" value="6"/>
        <border name="title_border" left="10" right="10" top="1" bottom="0"/>
        <border name="button_border" left="0" right="0" top="0" bottom="0"/>
        <aspect_ratio name="button" value="1"/>
</frame_geometry>
```

Dies sollte ebenso für die `frame_geometry` mit `name=„max“` geschehen
und dann muss ein Neustart der Gnome Shell geschehen, der dazu führt,
dass das Theme neu interpretiert wird. Dazu tippt man in den durch
STRG-F2 gestarteten Eingabeprompt `r` ein und Drückt dann Enter.

Die Tatsache, warum dieser Tipp nicht wirklich elegant ist, besteht
darin, dass durch ein Update des Themes die Änderungen überschrieben
werden. Da sich der Aufwand meiner Meinung nach in Grenzen hält, ist
dies aber kein wirkliches Problem. Man kann wohl damit rechnen, dass das
Theme bis zum Release von Gnome 3.1 noch einige kleine Anpassungen
erhält und darunter sollten dann auch die dicken Ränder fallen.

Nützliche Gnome Shell Extensions
++++++++++++++++++++++++++++++--

Wie schon eingangs erläutert, bietet die Gnome Shell die Möglichkeit zur
Erweiterung durch sogenannte Extensions. Die Extensions bestehen
mindestens aus den Dateien `extensions.js` und `metadata.json`, wobei in
letzterer auch Informationen zur gewünschten Gnome Shell-Version stehen
müssen, was beim Update der Shell.

In Gnome 3.0 gibt es noch keine komfortable GUI zum Verwalten der
Extensions, weshalb das Installieren eines Plugins mit dem Kopieren der
oben genannten Dateien in das Verzeichnis
`~/.local/share/gnome-shell/extensions` vollzogen wird. Dabei werden die
Plugins in Verzeichnisse mit dem Namen der UID aus der `metadata.json`
unterteilt.

### Gnome Shell-Integration für Messenger Pidgin

Eines der angepriesenen Features von Gnome 3 ist die sinnvolle
Integration des Gnome Messenger
[Empathy](http://live.gnome.org/Empathy "http://live.gnome.org/Empathy")
in die Shell. Das nachfolgende Plugin erreicht diese Integration auch
für den wesentlich populäreren Messenger
[Pidgin](http://pidgin.im "http://pidgin.im").

Die Extension ist auf [Github](http://github.com "http://github.com")
gehostet
[https://github.com/kagesenshi/gnome-shell-extensions-pidgin](https://github.com/kagesenshi/gnome-shell-extensions-pidgin "https://github.com/kagesenshi/gnome-shell-extensions-pidgin")
und dort ist es möglich die aktuellste Version des Plugins
herunterzuladen. Nach einem Neustart der Shell mit STRG-F2 und `r`
sollte das Plugin zur Verfügung stehen.

### Ersatz für Gnome System Monitor Applet

Ein sehr nützliches Tool unter Gnome 2 war das System Monitor Applet,
welches einem Informationen über seine Hardware in das Panel brachte.
Nach der Abkehr von den Applets war ich sehr froh darüber, dass dafür
ein Ersatz entwickelt wurde, welcher das Applet in Funktion und Design
um Längen schlägt.

Die Extension ist ebenfalls auf Github verfügbar:
[https://github.com/paradoxxxzero/gnome-shell-system-monitor-applet\#readme](https://github.com/paradoxxxzero/gnome-shell-system-monitor-applet#readme "https://github.com/paradoxxxzero/gnome-shell-system-monitor-applet#readme")

Den Vorgang des Installieren erläutern Anweisungen unterhalb der
Screenshots, weshalb ich an dieser Stelle nicht weiter darauf eingehen
werde.

### Weitere nützliche Extensions

Es gibt noch zahlreiche weitere Extensions, wobei
[HIER](http://www.fedorawiki.de/index.php?title=Gnome_3_Extensions&oldid=15089 "http://www.fedorawiki.de/index.php?title=Gnome_3_Extensions&oldid=15089")
eine ziemlich umfangreiche Aufstellung der verfügbaren Extensions zu
finden ist.

folgende Extensions werden vom Autor ebenfalls eingesetzt.

-   `noa11y` (Zum Ausblenden des Barrierefreiheit-Icon )
-   `moveclock` (Verschieben der Uhr auf die rechte Seite, wo sie hingehört)
