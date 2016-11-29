+++

tags = ["tuxorials", "german"]
layout = "post"
title = "Gnome Shell - Plugin-Versionskontrolle entschärfen"
date = "2012-12-31"

+++

>
> Dieser Artikel wurde von [tuxorials.de](http://tuxorials.de) (Dokuwiki) hierher migriert!
> Mögliche Darstellungsfehler bitte ich zu entschuldigen.
>


Die Gnome Shell, als neue Oberfläche des Gnome Desktops, erlaubt es
durch Plugins erweitert zu werden. Diese Plugins werden in Javascript
entwickelt und können die Funktionen der Gnome-Shell sehr stark
modifizieren. Ein Problem, welches in der Version 3.0 besteht, ist der
sehr restriktive Check auf die im Plugin angegebene Gnome-Shell-Version,
was bei einem Update der Gnome Shell dazu führt, dass die Plugins nicht
mehr geladen werden. Eine Lösung für dieses Problem liefert dieser
Beitrag.

Gnome Shell Extensions bestehen aus einem Verzeichnis mit einem
eindeutigen Namen, sowie zwei Dateien `extension.js` und
`metadata.json`. Erweiterungen können von jedem Nutzer im Verzeichnis
`~/.local/share/gnome-shell/extensions/` installiert werden, wobei nach
der Installation die Gnome-Shell neu gestartet werden muss (Drücken Sie
STRG-F2 und geben Sie dort „r“ ein).

Nachfolgend ist als Beispiel eine `metadata.json` dargestellt, welche
der Pidgin-Integration der Gnome-Shell entnommen ist:

```
{
 "uuid": "pidgin@gnome-shell-extensions.gnome.org",
 "name": "Pidgin IM Integration",
 "description": "Display Pidgin chats as notifications in the Shell message tray.",
 "shell-version": [ "3.0.2" ],
 "localedir": "/usr/share/locale",
 "url": "https://github.com/kagesenshi/gnome-shell-extensions-pidgin"
}
```

Wie schwer zu übersehen ist, steht dort die Gnome-Shell-Version hart
codiert und die Shell überprüft diese Angabe auch sehr genau, was ein
wirkliches Problem darstellt.

Die Lösung für dieses Problem ist folgendes Script, welches durch einen
Eintrag in die Datei `/etc/rc.local` beim Starten des X-Servers
ausgeführt wird und die Versionen aller installierten Plugins auf die
aktuell installierte Gnome-Shell-Version korrigiert.

[update\_extension\_version.sh](/doku.php/wiki:linux:gnome_shell_-_plugin-versionskontrolle_entschaerfen?do=export_code&codeblock=1 "Schnipsel herunterladen")
:   ~~~~ {.code .bash}
    #!/bin/bash
    #
    # Script, welches die Gnome-Shell-Version in den Erweiterungen auf
    # die aktuell installierte Version updatet. 
    #
    # Autor: Philipp Böhm
    # URL: http://www.tuxorials.de
    # Lizenz: GNU General Public License v2
    # Lizenztext: http://www.gnu.org/licenses
    # 
    VERSION=`gnome-shell --version | cut -d " " -f3`
     
    USER=philipp
    cd /home/$USER/.local/share/gnome-shell/extensions
     
    for file in `find -L .  -name metadata.json`
    do
        sed -i " s/.*shell-version.*/ \"shell-version\": [ \"$VERSION\" ],/ " $file
    done
    ~~~~
