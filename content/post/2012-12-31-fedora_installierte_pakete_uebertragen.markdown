+++
layout = "post"
title = "Fedora: Installierte Pakete übertragen"
date = "2012-12-31"

+++

>
> Dieser Artikel wurde von [tuxorials.de](http://tuxorials.de) (Dokuwiki) hierher migriert!
> Mögliche Darstellungsfehler bitte ich zu entschuldigen.
>


Wenn es zur Neuinstallation von Fedora kommt (z.B. wegen einem neuen
Gerät oder wegen einem neuen Release), dann ist es sehr praktisch, eine
Liste der installierten Pakete zu haben, diese zu speichern und auf dem
neuen System wieder einzuspielen. Eine Liste der aktuell auf dem System
installierten Pakete liefert folgender Befehl, welcher die Liste in die
Datei `pkglist.txt` schreibt:

```
# rpm -qa | sort > pkglist.txt
```

Wenn man sich diese Datei dann betrachtet, wird man feststellen, dass
die Pakete Versionsnummern und anderen `Ballast` enthalten, welcher sich
beim Zurückspielen negativ auswirken könnte, weil Pakete nicht gefunden
werden könnten. Deshalb befreit folgender Befehl die Pakete von dem
unnützen Ballast und schreibt sie in eine andere Datei:

```
# cat pkglist.txt | perl -e 'while(<STDIN>) { my ($prog) = $_ =~ /(.*?)-\d+/; print $prog, "\n"; }' > cleanpkglist.txt
```

Interessant an diesem Perl-Konstrukt ist die Verwendung der
`non-greedy`-Quantifiern `.*?`, wodurch so wenig wie möglich durch einen
regulären Ausdruck gematcht wird. Das Rückspielen der Pakete erfolgt nun
mit folgendem Befehl, wobei der Dateiname entsprechend angepasst werden
muss:

```
# yum install `cat cleanpkglist.txt`
```
