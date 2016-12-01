+++
title = "SSH Features: Bridging two networks"
date = "2016-12-01T22:49:59+01:00"
draft = true
tags = ["devops", "ssh", "ethernet", "bridging"]

+++

For the first part of an ongoing series about little known SSH features,
we'll take a look at the `-w` command line flag which allows bridging of two
ethernet networks using TAP-devices.

<!--more-->

## Bridging via tap-devices

## Configuring bridge interfaces using systemd-networkd

{{< codeblock "/etc/systemd/network/br-remote.netdev" "ini" >}}
[NetDev]
Name=br-remote
Kind=bridge
{{< /codeblock >}}

{{< codeblock "/etc/systemd/network/br-remote.network" "ini" >}}
[Match]
Name=br-remote
{{< /codeblock >}}


## LocalCommand

## Putting it all together

{{< codeblock "ssh-bridge" "bash" >}}
ssh -o "PermitLocalCommand=yes" \
    -o "LocalCommand=brctl addif br-local tap5 && ifconfig tap5 up" \
    -o Tunnel=ethernet \
    -w 5:5 \
    -t root@$REMOTE_HOST \
    "brctl addif br-remote tap5 && ifconfig tap5 up"
{{< /codeblock >}}
