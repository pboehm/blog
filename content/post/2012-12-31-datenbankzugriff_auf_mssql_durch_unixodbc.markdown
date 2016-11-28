+++
layout = "post"
title = "Datenbank-Zugriff auf Microsoft SQL-Server von Linux"
date = "2012-12-31"

+++

>
> Dieser Artikel wurde von [tuxorials.de](http://tuxorials.de) (Dokuwiki) hierher migriert!
> Mögliche Darstellungsfehler bitte ich zu entschuldigen.
>


Dieser Beitrag beschreibt den Datenbankzugriff auf einen MSSQL-Server
durch einen Linux-Host, mit Hilfe von
[unixODBC](http://unixodbc.org "http://unixodbc.org"), sowie die Nutzung
dieser Verbindung durch [Perl](http://perl.org "http://perl.org"). Wenn
man sich eine MySQL Datenbank betrachtet, dann ist die lokal über einen
Unix-Domain-Socket und über den TCP/IP-Stack an einem bestimmten Port
erreichbar. Wenn man sich jetzt hingegen den Microsoft SQL-Server
betrachtet, dann ist der Zugriff auch über Netzwerk möglich, jedoch nur
über eine Technologie namens ODBC (Open Database Connectivity). Auf
einem Windows-Host sind die passenden ODBC-Treiber meistens vorhanden,
auf unixoiden Betriebssystemen ist dafür eine Software wie unixODBC und
ein passender Treiber notwendig. Für MSSQL und Sybase (der Basis von
MSSQL) liefert das
[FreeTDS](http://freetds.org "http://freetds.org")-Projekt einen
passenden ODBC-Treiber.

Vorraussetzungen
+++++++++++++++-

-   unixODBC
-   FreeTDS

Diese Tools stehen durch bestimmte Pakete in den Distributionen bereit
und müssen nur noch installiert werden. Unter
[Fedora](http://fedoraproject.org "http://fedoraproject.org") und RHEL
sind das die Pakete `freetds`, `freetds-devel` und `unixODBC`.

Konfiguration der ODBC-Verbindung
+++++++++++++++++++++++++++++++++

### Publizieren des FreeTDS-Treibers

Als erstes muss unixODBC der FreeTDS-Treiber beigebracht werden, sodass
unixODBC darauf zugreifen kann. Dabei erstellt man folgende Datei und
wendet dann das nachfolgende Kommando darauf an.

```
[FreeTDS]
Driver      = /usr/lib/libtdsodbc.so.0
UsageCount   = 1
```

```
# odbcinst -i -d -f /etc/odbcinst.ini
```

Dabei ist zu beachten, dass der Pfad zur libtdsodbc.so variieren kann,
der nachfolgende Befehl sucht nach passenden Libraries.

```
# find /usr/lib -regex "libtdsodbc.*"
```

### Erstellen einer DSN (Data Source Name)

Nachfolgend muss eine DSN erstellt werden, die die notwendigen Parameter
für die Datenbank-Verbindung festlegt.

```
[MSSQL]
Driver   = FreeTDS
Server   = 192.168.1.10\SQLEXPRESS
Port      = 1433
Database  = DATABASE
```

```
# odbcinst -i -s -f /etc/odbc.ini
```

Wenn keine Fehler ausgegeben werden, ist die Verbindung erfolgreich
hinzugefügt und kann nachfolgend getestet werden.

### Testen der Verbindung

Zum Testen der Verbindung bietet unixODBC das Tool `isql`, welches
nachfolgend dargestellt wird, um eine Verbindung zur Datenbank
herzustellen. Der zweite und dritte Parameter sind dabei Nutzername und
Passwort für den Datenbank-Nutzer.

```
# isql -v MSSQL-Perl dbuser sehrsicher
+++++++++++++++++++++++++++++++++++++++++
| Connected!                            |
|                                       |
| sql-statement                         |
| help [tablename]                      |
| quit                                  |
|                                       |
+++++++++++++++++++++++++++++++++++++++++
SQL> 
```

In diesem Tool können dann auch SQL-Statements angegeben und abgesetzt
werden.

Nutzung der ODBC-Verbindung in Perl
+++++++++++++++++++++++++++++++++--

Wie in Perl üblich, verwendet man für Datenbankzugriffe jeglicher Art
das Modul [DBI](http://dbi.perl.org/ "http://dbi.perl.org/") (Database
Interface) und für den Zugriff auf MSSQL-Server ist ebenfalls ein Plugin
vorhanden. Das Plugin
[DBD::ODBC](http://search.cpan.org/~mjevans/DBD-ODBC/ODBC.pm "http://search.cpan.org/~mjevans/DBD-ODBC/ODBC.pm")
ist in den Distributionen als Paket vorhanden, wenn dies wie im Falle
von Fedora nicht der Fall sein sollte, installiert der folgende Befehl
das Modul mit allen Abhängigkeiten. Als Vorraussetzung gilt, dass dafür
die devel-Pakete von FreeTDS und unixODBC, sowie die typischen
Build-Tools (gcc …) installiert sind.

```
# cpan
cpan [1]> install DBD::ODBC
```

Wenn das Kompilieren erfolgreich war, kann man die CPAN-Shell mit
mehrmaligen STRG-C verlassen.

### Beispiel Sourcecode

```
#!/usr/bin/perl -w
#
#       unixodbc_perltest.pl
#
#       Copyright 2011 Philipp Böhm <philipp-boehm@live.de>
#
#       This program is free software; you can redistribute it and/or modify
#       it under the terms of the GNU General Public License as published by
#       the Free Software Foundation; either version 2 of the License, or
#       (at your option) any later version.
#
#       This program is distributed in the hope that it will be useful,
#       but WITHOUT ANY WARRANTY; without even the implied warranty of
#       MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#       GNU General Public License for more details.
#
#       You should have received a copy of the GNU General Public License
#       along with this program; if not, write to the Free Software
#       Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
#       MA 02110-1301, USA.
#
#       Erfordert das Perl-Modul DBD::ODBC
#
 
use strict;
use Data::Dumper;
use DBI;
 
################################################################################
############### SQL-Queries ####################################################
################################################################################
my %QUERIES = (
    ###
    # Query für MSSQL
 
    "get_call_data" => q{ SELECT
                            Id AS CallID,
                            [Caller-ID] AS SIP,
                            Start,
                            [End],
                            DATEDIFF(second, [Start], [End]) AS Length
                          FROM Calls
                          WHERE ((datename(yyyy, Start)) >= 2011)
                          AND LEN([Caller-ID]) = 4
                          AND Id > ?;
                        },
);
 
################################################################################
############### Datenbank-Handle erstellen #####################################
################################################################################
my $dsn = "MSSQL"; # aus /etc/odbc.ini
my $dbh = DBI->connect(
    "dbi:ODBC:$dsn", "dbusername"}, "dbpassword"
) or die "Konnte keine Verbindung zur DB aufbauen: $DBI::errstr";
 
################################################################################
############### SELECT-Statement absetzen ######################################
################################################################################
my $calldata = $dbh->prepare( $QUERIES{"get_call_data"} );
$calldata->execute(1000);
 
while ( my $line = $calldata->fetchrow_hashref ) {
    print Dumper($line);
}
```

Die im Code enthaltenen Kommentare sollten die Funktion des Codes
ausreichend darstellen.

### Einschränkung

Eine Beschränkung des FreeTDS-Treiber liegt darin, dass immer nur ein
Statement-Handle pro Verbindung gleichzeitig bestehen kann. Wenn Sie es
doch versuchen, ist es wahrscheinlich dass Sie folgenden Fehler
erhalten:

```
Invalid cursor state (SQL-24000)
```

Diese Einschränkung hat Microsoft erst im MSSQL-Server 2005 mit
Einführung der Technologie
`Multiple Active Result Sets` beseitigt, eine reife Leistung !!.
