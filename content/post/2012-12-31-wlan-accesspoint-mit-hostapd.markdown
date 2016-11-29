+++

tags = ["tuxorials", "german"]
layout = "post"
title = "WLAN-Accesspoint mit hostapd"
date = "2012-12-31"

+++

>
> Dieser Artikel wurde von [tuxorials.de](http://tuxorials.de) (Dokuwiki) hierher migriert!
> Mögliche Darstellungsfehler bitte ich zu entschuldigen.
>


Der Inhalt dieses Beitrages ist die Konfiguration eines Linux zu einem
WLAN-Accesspoint, sodass andere Nutzer sich drahtlos mit ihm verbinden
können. Diese Funktionalität bieten sonst bloß integrierte Router, wie
sie zuhauf in allen Elektronikmärkten und auch Wohnzimmern stehen. Es
gibt aber halt auch die Möglichkeit dies mit jedem Linux nachzubauen.

*Wozu benötigt man so eine Funktionalität nun auf einem Notebook, hier
ein Beispiel:*

Sie befinden sich in einer Situation, wo Sie eine Internetverbindung für
andere bereitstellen wollen, jedoch nur über einen Anschluss verfügen.
Dies kann z.B. eine UMTS-Verbindung mit Hilfe eines USB-Dongles oder
eine einzige freie Netzwerkbuchse sein. Nun sitzt man mit mehreren
Leuten im Park oder im Unterricht und möchte jedem eine
Internetverbindung bereitstellen, egal ob das nun für ein Smartphone
oder Netbook ist. Es gibt nun die Möglichkeit das Notebook mit der
Internetverbindung, welches natürlich ein Linux am Laufen hat, als
Accesspoint zu konfigurieren und den anderen die Internetverbindung zur
Verfügung zu stellen. Dies geschieht mit Hilfe von `hostapd`, welches
nachfolgend erklärt wird:

*Konfiguration:* Es muss das Programm `hostapd` installiert werden,
welches meistens nicht direkt vorhanden ist. Mit dem
distributionsspezifischen Paketmanager wird das jeweilige Paket
installiert und dabei eine Beispiel-Konfiguration unterhalb von `/etc`
erzeugt.

```
root@fedora #] yum install hostapd
```

Jetzt müssen die Parameter gesetzt werden, sodass z.B die SSID und die
Verschlüsselungsart festgelegt wird. Die Konfiguration geschieht in der
Datei `/etc/hostapd/hostapd.conf`, welche nachfolgend dargestellt ist.
(Die fettgedruckten Parameter müssen Sie selbst festlegen)

```
# 
# This will give you a minimal, insecure wireless network. 
#  
# DO NOT BE SATISFIED WITH THAT!!! 
# 
# For more information, look here: 
# 
#    http://wireless.kernel.org/en/users/Documentation/hostapd 
#  
ctrl_interface=/var/run/hostapd 
ctrl_interface_group=wheel  

# Some usable default settings... 
macaddr_acl=0 
auth_algs=1 
ignore_broadcast_ssid=0  

# Uncomment these for base WPA & WPA2 support with a pre-shared key 
wpa=3 
wpa_key_mgmt=WPA-PSK 
wpa_pairwise=TKIP 
rsn_pairwise=CCMP  

# DO NOT FORGET TO SET A WPA PASSPHRASE!! 
wpa_passphrase=testtest  

# Most modern wireless drivers in the kernel need driver=nl80211
driver=nl80211  

# Customize these for your local configuration... 
interface=wlan0 
hw_mode=g 
channel=11 
ssid=test
```

Die hier vorgestellte Konfiguration funkt auf Kanal `11` unter dem
WLAN-Standard `802.11g` mit der SSID `test`. Dabei wird ein sicherer
Verschlüsselungsalgorithmus eingesetzt und die Clients müssen als
WPA-Passphrase `testtest` eingeben. Außerdem ist das Interface
festgelegt, welches als Access-Point konfiguriert werden soll (Hier
`wlan0`). Dabei kommt es darauf an, dass der Treiber für das Interface
den Monitor-Mode unterstützt, was bei den Treibern `ath5k` und `ath9k`
aber auch bei vielen anderen gegeben ist.

Damit ist die Konfiguration eigentlich schon abgeschlossen, weshalb wir
nachfolgend den hostapd-Dienst starten können:

```
yum@fedora #] service hostapd start
```

Nun sollte nach Fehlermeldungen Ausschau gehalten werden. Diese können
direkt beim Starten des Dienstes auf `stdout` oder in Log-Dateien wie
`/var/log/messages` bzw. `/var/log/syslog` geschrieben werden. So
erfährt man auch, ob der jeweilige Treiber den benötigten Modus
überhaupt unterstützt. Es wird dabei ein neues Interface erstellt, was
bei dem eigentlichen Interface wlan0 dann `mon.wlan0` heißt. Wenn keine
Fehlermeldungen ausgegeben wurden, strahlt das Notebook nun die SSID
`test` an alle aus und die Clients können sich mit dem Notebook
verbinden. Sie bekommen jedoch noch keine IP zugewiesen, da noch ein
DHCP-Server gestartet werden muss. Die Konfiguration dessen ist Inhalt
eines eigenen Beitrages. Wenn dies geschehen ist, ist der Accesspoint
einsatzbereit. Das Bereitstellen der Internetverbindung ist ebenfalls
Inhalt eines eigenen Artikels.
