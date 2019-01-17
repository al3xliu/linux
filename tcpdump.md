# Tcpdump Tutorial

__Note__: This doc is from `https://danielmiessler.com/study/tcpdump/` and just for personal learning.

## Practical Examples

### basic communication

Just see what’s going on, by looking at what’s hitting your inteface.

```shell
tcpdump -i eth0
```

### find traffic by ip

```
tcpdump host 1.1.1.1
```
### filtering by source and/or destination

If you only want to see traffic in one direction or the other, you can use src and dst.

```
tcpdump src 1.1.1.1
tcpdump dst 1.0.0.1
```

### finding packets by network

To find packets going to or from a particular network or subnet, use the net option.

```
tcpdump net 1.2.3.0/24

```

### get packet contents with hex output

Hex output is useful when you want to see the content of the packets in question, and it’s often best used when you’re isolating a few candidates for closer scrutiny.

```
tcpdump -c 1 -X icmp
```

### show traffic related to a specific port

You can find specific port traffic by using the port option followed by the port number.

```
tcpdump port 3389
tcpdump src port 1025
```

### show traffic of one protocol

```
tcpdump icmp
```

### find traffic using port ranges

```
tcpdump portrange 21-23
```

### find traffic based on packet size

If you’re looking for packets of a particular size you can use these options. You can use less, greater, or their associated symbols that you would expect from mathematics.

```
tcpdump less 32
tcpdump greater 64
tcpdump <= 128
```



## Advanced

Here are some additional ways to tweak how you call tcpdump.

- -A : Print each packet (minus its link level header) in ASCII. Handy for capturing web pages.
- -X : Show the packet’s contents in both hex and ascii.
- -XX : Same as -X, but also shows the ethernet header.
- -D : Show the list of available interfaces
- -l : Line-readable output(for viewing as you save, or sending to other commands)
- -q : Be less verbose (more quiet) with your output.
- -t : Give human-readable timestamp output.
- -tttt : Give maximally human-readable timestamp output.
- -i eth0 : Listen on the eth0 interface.
- -c : Only get x number of packets and then stop.
- -s : Define the snaplength (size) of the capture in bytes. Use -s0 to get everything, unless you are intentionally capturing less.
- -S : Print absolute sequence numbers.
- -e : Get the ethernet header as well.
- -E : Decrypt IPSEC traffic by providing an encryption key.
- -O (--no-optimize) : Do not run the packet-matching code optimizer. This is useful only if you suspect a bug in the optimizer.


### from specific ip and destined for a specific port

Let’s find all traffic from 10.5.2.3 going to any host on port 3389.

```
tcpdump -nnvvS src 10.5.2.3 and dst port 3389
```

### from one network to another

Let’s look for all traffic coming from 192.168.x.x and going to the 10.x or 172.16.x.x networks, and we’re showing hex output with no hostname resolution and one level of extra verbosity.

```
tcpdump -nvX src net 192.168.0.0/16 and dst net 10.0.0.0/8 or 172.16.0.0/16
```

### non icmp traffic going to a specific ip

```
tcpdump dst 192.168.0.2 and src net and not icmp
```

### traffic from a host that isn’t on a specific port

```
tcpdump -vv src mars and not dst port 22
```

Keep in mind that when you’re building complex queries you might have to group your options using single quotes. Single quotes are used in order to tell tcpdump to ignore certain special characters—in this case below the “( )” brackets. This same technique can be used to group using other expressions such as host, port, net, etc.

```
tcpdump 'src 10.0.2.4 and (dst port 3389 or 22)'
```

## isolate tcp flags

### Isolate TCP RST flags.

```
tcpdump 'tcp[13] & 4!=0'
tcpdump 'tcp[tcpflags] == tcp-rst'
```

### Isolate TCP SYN flags.

```
tcpdump 'tcp[13] & 2!=0'
tcpdump 'tcp[tcpflags] == tcp-syn'
```

### Isolate packets that have both the SYN and ACK flags set.

```
tcpdump 'tcp[13]=18'
```

### Isolate TCP URG flags.

```
tcpdump 'tcp[13] & 32!=0'
tcpdump 'tcp[tcpflags] == tcp-urg'
```

### Isolate TCP ACK flags.

```
tcpdump 'tcp[13] & 16!=0'
tcpdump 'tcp[tcpflags] == tcp-ack'
```

### Isolate TCP PSH flags.

```
tcpdump 'tcp[13] & 8!=0'
tcpdump 'tcp[tcpflags] == tcp-psh'
```

### Isolate TCP FIN flags.

```
tcpdump 'tcp[13] & 1!=0'
tcpdump 'tcp[tcpflags] == tcp-fin'
```


## Everyday Recipe Examples

### both syn and rst set

```
tcpdump 'tcp[13] = 6'
```

### find http user agents

```
tcpdump -vvAls0 | grep 'User-Agent:'
```


### cleartext get requests

```
tcpdump -vvAls0 | grep 'GET'
```

### find http host headers

```
tcpdump -vvAls0 | grep 'Host:'
```

### find http cookies

```
tcpdump -vvAls0 | grep 'Set-Cookie|Host:|Cookie:'
```

### find ssh connections

This one works regardless of what port the connection comes in on, because it’s getting the banner response.

```
tcpdump 'tcp[(tcp[12]>>2):4] = 0x5353482D'
```


### find dns traffic

```
tcpdump -vvAs0 port 53
```

### find ftp traffic

```
tcpdump -vvAs0 port ftp or ftp-data
```

### find ntp traffic

```
tcpdump -vvAs0 port 123
```

### find cleartext passwords

```
tcpdump port http or port ftp or port smtp or port imap or port pop3 or port telnet -lA | egrep -i -B5 'pass=|pwd=|log=|login=|user=|username=|pw=|passw=|passwd= |password=|pass:|user:|username:|password:|login:|pass |user '
```
