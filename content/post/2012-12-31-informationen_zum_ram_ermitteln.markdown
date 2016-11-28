+++
layout = "post"
title = "Informationen über RAM ermitteln"
date = "2012-12-31"

+++

>
> Dieser Artikel wurde von [tuxorials.de](http://tuxorials.de) (Dokuwiki) hierher migriert!
> Mögliche Darstellungsfehler bitte ich zu entschuldigen.
>


Wenn man kurz vor dem Kauf von zusätzlichen RAM steht, benötigt man
detaillierte Informationen zu den bereits existierenden RAM-Riegeln.
Dieser Beitrag stellt unter Linux verfügbare Tools vor, die einem bei
dieser Aufgabe unterstützen.

Freien Arbeitsspeicher ermitteln
++++++++++++++++++++++++++++++--

Wenn Sie das Gefühl haben, dass der vorhandene Arbeitsspeicher nicht
ausreicht, dann kann dies mit Hilfe des Tools `free` bestätigt werden.

```
$ free
             total       used       free     shared    buffers     cached
Mem:       2051976    1908216     143760          0      86592    1237900
-/+ buffers/cache:     583724    1468252
Swap:      2097144       1424    2095720
```

Detaillierte Informationen extrahieren
++++++++++++++++++++++++++++++++++++--

Wenn Sie sich nun zum Kauf von zusätzlichen Speicherriegeln
durchgerungen haben, benötigen Sie Angaben zu Taktfrequenzen und Größe
von bereits installierten Riegeln, sowie Informationen über die maximal
verwaltbare Menge an Arbeitsspeicher. Außerdem können Sie nachschauen ob
das Mainboard noch freie Slots besitzt oder ob Sie vorhandene Riegel
ersetzen müssen.

Alle gewünschten Informationen stellt das Tool `dmidecode` bereit,
welches root-Rechte benötigt.

```
# dmidecode -t memory
SMBIOS 2.5 present.

Handle 0x0012, DMI type 16, 15 bytes
Physical Memory Array
   Location: System Board Or Motherboard
   Use: System Memory
   Error Correction Type: None
   Maximum Capacity: 8 GB                 <== Maximale verwaltbare Größe
   Error Information Handle: Not Provided
   Number Of Devices: 4                   <== Anzahl der Slots
   
Handle 0x0013, DMI type 17, 27 bytes
Memory Device
   Array Handle: 0x0012
   Error Information Handle: No Error
   Total Width: 40968 bits
   Data Width: 41032 bits
   Size: 1024 MB
   Form Factor: DIMM
   Set: 1
   Locator: J6G1
   Bank Locator: DIMM 0
   Type: DDR2
   Type Detail: Synchronous
   Speed: 667 MHz (1.5 ns)    <= Taktrate
   Manufacturer: Kingston     <= Hersteller                                        
   Serial Number: 9ECCA19C
   Asset Tag: 00000920
   Part Number: 202020202020202020202020202020202020
# Ausgabe gekürzt
```
