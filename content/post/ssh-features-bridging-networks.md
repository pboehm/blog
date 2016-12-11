+++
title = "SSH Features: Bridging two networks"
date = "2016-12-07T22:49:59+01:00"
tags = ["devops", "ssh", "ethernet", "bridging", "osi"]
draft = false
+++

There are many cases where two networks have to be connected on Layer 2 in a
virtual fashion, which is referred to as a Virtual Private Network (VPN).
Typically you would use [OpenVPN](https://openvpn.net/) or similar software
for that. All of these tools have in common that they require some non trivial
setup steps like setting up a PKI or exchanging keys or certificates in a
safe way.

As a programmer, setting up a full fledged VPN software for a development
environment which is destroyed regularly seems not be the best option. A
question that normally comes to my mind in these moments is:

> Can I use SSH for that?

The answer is usually YES, like in this case. For the first part of an ongoing
series about little known SSH features, we'll take a look at the `-w` command
line flag which allows bridging of two ethernet networks using `tap`-devices.

<!--more-->

## Bridging via tap-devices

VPNs can be implemented on different
[OSI](https://en.wikipedia.org/wiki/OSI_model)-layers which depends on the
desired network architecture. Usually you have to choose between a Layer-2 or
Layer-3-VPN which can be compared to connecting two separate network segments
using either a switch (Layer 2) or a router (Layer 3). Choosing between these
two types of VPNs also corresponds to the type of virtual network interface
which have to be used. A Layer-2-VPN requires the usage of a `tap`-device while
a Layer-3-VPN is usually implemented using a `tun`-device.

OpenSSH supports both tunneling on Layer-2 and Layer-3 but the rest of this post
will focus on Layer-2-VPNs using `tap`-devices.

## Prerequisites

This feature requires an OpenSSH server to be installed on the remote site
with the following settings configured in `/etc/ssh/sshd_config`:

{{< codeblock "/etc/ssh/sshd_config" "config" >}}
# ...
PermitTunnel yes
PermitRootLogin yes
{{< /codeblock >}}

As you can see this setup requires root login, because creating tap devices
normally requires these permissions. `PermitRootLogin yes` allows login as
root using a password which is naturally a bad idea. If possible
`PermitRootLogin without-password` should be used instead, which allows login
as root only using public key authentication.

### Creating the tunnel

```
root » ssh -o Tunnel=ethernet -w 5:5 -t root@REMOTE_HOST
```

After executing this command with successful authentication a device called
`tap5` is created on each side of the tunnel, which works but the interface
are shut down. The argument `-w X:Y` specifies which device numbers should
be used on the local and remote side.

## Configuring bridge interfaces using systemd-networkd

`tap`-devices are not that useful without being attached to a real network
interface. That's the reason why they are normally attached to a bridge
interface on each side. Setting up bridge interfaces is usually done using
the `brctl` command provided by the `bridge-utils` package. For distributions
using `systemd` and its network daemon the following two config files
will create the bridge interface `br-remote` in a way that survives a reboot.

{{< codeblock "/etc/systemd/network/br-remote.netdev" "ini" >}}
[NetDev]
Name=br-remote
Kind=bridge
{{< /codeblock >}}

{{< codeblock "/etc/systemd/network/br-remote.network" "ini" >}}
[Match]
Name=br-remote
{{< /codeblock >}}

After adding these files the following command has to be executed for the
network daemon to apply the new configuration:

```
systemctl restart systemd-networkd
```

Now we have a working bridge interface called `br-remote` which has no
interfaces attached to it. Adding the `tap5` interface to the bridge is done
by the following command:

```
root » brctl addif br-remote tap5
```

## Putting it all together

Because the simple SSH command described above requires some additional commands
to be executed on both sides of the tunnel it would be cool to join these
commands in a single command executed on the client.

A well known feature of SSH is that the first real argument to the ssh command is
treated as a command that is executed on the remote side after setting up the
tunnel. A lesser known feature is that this also exists for the local
side through the `LocalCommand` option which executes a command on the local
side after setting up the SSH tunnel.

The following command assumes that a bridge interface `br-local` exists on
the local side while `br-remote` exists on the remote side:

{{< codeblock >}}
root » ssh -o "PermitLocalCommand=yes" \
           -o "LocalCommand=brctl addif br-local tap5 && ifconfig tap5 up" \
           -o Tunnel=ethernet \
           -w 5:5 \
           -t root@REMOTE_HOST \
           "brctl addif br-remote tap5 && ifconfig tap5 up"
{{< /codeblock >}}
