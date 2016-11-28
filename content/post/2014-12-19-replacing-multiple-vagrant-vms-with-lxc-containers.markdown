+++
layout = "post"
title = "Replacing multiple Vagrant VMs with LXC containers"
date = "2014-12-19"

+++

I'm currently working in an environment where the development setup consists of
6 individual VirtualBox VMs handled by [vagrant](http://vagrantup.com). This
could be a problem on devices with low amount of memory, such as Macbook Air
...

This post describes a setup with a single VM which hosts all other VMs as LXC
containers with minimal overhead. The tricky part here is the network setup, so
that your developer machine is in the same network as the containers, which
then allows direct access to and from the containers.

This setup also allows the usage of LXC on developer machines running OSX or
Windows, which normally doesn't support LXC.

The developer machine and all LXC containers are connected to
an ethernet bridge `lxcbr1` inside the base box. This interface acts like a
normal ethernet switch and is the key component of this solution.

## Project Layout

```
.
├── Vagrantfile
└── deployment
    └── Vagrantfile
```

The `Vagrantfile` in the project root handles the base box and mounts the
directory `deployment/` into the box. Inside the base box, the other
`Vagrantfile` is used for setting up the LXC containers.

## The Base Box

#### `Vagrantfile`

```ruby
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "ubuntu/trusty64"
  config.vm.hostname = "devbox"
  config.vm.synced_folder "deployment/", "/deployment"
  config.vm.network "private_network", ip: "192.168.42.10", auto_config: false

  config.vm.provider "virtualbox" do |vb|
     vb.customize ["modifyvm", :id, "--memory", "1024"]
     vb.customize ["modifyvm", :id, "--nicpromisc2", "allow-all"]
  end

  config.vm.provision :shell, :inline => BOX_SETUP_SCRIPT, privileged: false
  config.vm.provision :shell, :inline => VAGRANT_STARTUP_SCRIPT, run: "always", privileged: false
end
```

Pay attention to the `--nicpromisc2` argument, which tells VirtualBox to put
the second interface into promiscuous mode, so that all traffic reaching the
interface will be transfered. Without this flag, no direct communication
between the developer machine and any LXC-container would be successful.

```
BOX_SETUP_SCRIPT = <<END
#!/bin/bash

sudo apt-get update
sudo apt-get install -y lxc lxc-templates cgroup-lite redir bridge-utils

cat << EOF > /tmp/lxcbr1.cfg
auto eth1
iface eth1 inet manual
        up ifconfig eth1 promisc up
        down ifconfig eth1 promisc down

auto lxcbr1
iface lxcbr1 inet static
    address 192.168.42.10
    broadcast 192.168.42.255
    netmask 255.255.255.0
    bridge_ports eth1
    bridge_stp off
    bridge_waitport 0
    bridge_fd 0
EOF

sudo mv /tmp/lxcbr1.cfg /etc/network/interfaces.d/lxcbr1.cfg

sudo service networking restart
sudo ifup lxcbr1

cd /tmp
wget -q https://dl.bintray.com/mitchellh/vagrant/vagrant_1.6.5_x86_64.deb

sudo dpkg -i vagrant_1.6.5_x86_64.deb
vagrant plugin install vagrant-lxc
END
```

This script is used once for setting up the base box by installing `vagrant`,
`vagrant-lxc`, all dependencies and also configures the `lxcbr1`-bridge
persistently.

```
VAGRANT_STARTUP_SCRIPT = <<END
#!/bin/bash

cd /deployment
vagrant up
END
```

This provisioner script is executed every time `vagrant` starts the base
box and it boots the LXC containers.

## The Container Setup


#### `deployment/Vagrantfile`

```ruby
VAGRANTFILE_API_VERSION = "2"
BASE_IMAGE = "fgrehm/precise64-lxc"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  config.vm.define :lxc1 do |box|
    box.vm.hostname = "lxc1"
    box.vm.box = BASE_IMAGE
    box.vm.provider :lxc do |provider|
       provider.customize "network.type", "veth"
       provider.customize "network.flags", "up"
       provider.customize "network.link", "lxcbr1"
       provider.customize "network.ipv4", "192.168.42.2/24"
    end
  end

  config.vm.define :lxc2 do |box|
    box.vm.hostname = "lxc2"
    box.vm.box = BASE_IMAGE
    box.vm.provider :lxc do |provider|
       provider.customize "network.type", "veth"
       provider.customize "network.flags", "up"
       provider.customize "network.link", "lxcbr1"
       provider.customize "network.ipv4", "192.168.42.3/24"
    end
  end

  # ....
end
```

This `Vagrantfile` handles the LXC containers and is the place where you build
your infrastructure with LXC as a provider.

## Startup

```
# from inside your project
vagrant up

# this should be successful
ping 192.168.42.2
```
