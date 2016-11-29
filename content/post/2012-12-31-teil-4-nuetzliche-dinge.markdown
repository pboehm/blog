+++

tags = ["tuxorials", "german"]
layout = "post"
title = "Teil 4: Nützliche Dinge"
date = "2012-12-31"

+++

>
> Dieser Artikel wurde von [tuxorials.de](http://tuxorials.de) (Dokuwiki) hierher migriert!
> Mögliche Darstellungsfehler bitte ich zu entschuldigen.
>


Dieser Beitrag soll Platz für alle die kleinen Dinge bieten, die das
Arbeiten mit Shell-Scripten komfortabel und interaktiv machen. Es geht
hier z.B. um Benutzereingaben verarbeiten und functions.

*Benutzereingaben einlesen* Eine zentrale Komponente einer Software ist
die Reaktion auf Benutzereingaben und deswegen gibt es in Shell-Scripten
eine einfache und dabei leistungsfähige Möglichkeit Eingaben vom Nutzer
zu erfassen.

Das Mittel zum Zweck ist hier das Programm `read`, welches nachfolgend
dargestellt wird:

```
read [Optionen] Shellvariable
```

Beispiele:

```
read -p "Geben Sie eine Zahl ein: " choice echo $choice
```

Das vorherige Listing liest vom Nutzer einen Text ein und gibt ihn
danach wieder aus. Zugegeben, es hat wenig Sinn.

```
read -sp "Geben Sie die Passphrase ein: " passwd 
if [ [ `echo -e $passwd` == "abc12345" ]] 
then  
  echo "Sie sind erfolgreich angemeldet" 
else  
  echo "Die Passphrase ist falsch, wird beendet ..."  
  exit 
fi
```

Das vorherige Listing liest vom Nutzer eine Passphrase ein (ohne die
Eingaben darzustellen) und vergleicht die von Leerzeichen befreite
Eingabe mit einem Wert.
