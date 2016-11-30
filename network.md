#### part one network

* enable interface

```
  ifconfig eth0 up
```
or
```
  ip link set eth0 up
```

* disable interface
```
  ifconfig eth0 down
```
or
```
  ip link set eth0 down
```

* check ip addresses

```
  ip addr show
```

* add ip address

```
  ip addr add 192.168.0.10/24 dev eth0
```

* del ip address

```
  ip addr del 192.168.0.10/24 dev eth0
```

* add ip address permanently(bounding ethernet)

for ubuntu
```
  cd /etc/network/interfaces.d
  vim ifcfg-eth0
```

u can find config file as below
```
DEVICE="eth0"
BOOTPROTO=static
ONBOOT=yes
TYPE="Ethernet"
IPADDR=192.168.50.2
NAME="System eth0"
HWADDR=00:0C:29:28:FD:4C
GATEWAY=192.168.50.1
```

then restart network service
```
  service networking restart
```
for centos

```
 cd /etc/sysconfig/network-scripts/
 vim ifcfg-eth0
```

restart network
```
```

* check route table

```
  route -n
```
or
```
  ip route show
```

* add static route
```
  ip route add 10.20.0.0/24 via 192.168.0.1 dev eth0
```
* del static route
```
  ip route del 10.20.0.0/24
```

* add default GATEWAY

```
  ip route add default via 192.168.50.100
```
