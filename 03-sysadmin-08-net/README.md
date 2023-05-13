# Практическое задание по теме «Компьютерные сети 3»

1. Подключитесь к публичному маршрутизатору в интернет. Найдите маршрут к вашему публичному IP
```
telnet route-views.routeviews.org
Username: rviews
show ip route x.x.x.x/32
show bgp x.x.x.x/32
```
```bash
route-views>show ip route 109.167.136.174   
Routing entry for 109.167.128.0/18
  Known via "bgp 6447", distance 20, metric 0
  Tag 7018, type external
  Last update from 12.0.1.63 1w0d ago
  Routing Descriptor Blocks:
  * 12.0.1.63, from 12.0.1.63, 1w0d ago
      Route metric is 0, traffic share count is 1
      AS Hops 3
      Route tag 7018
      MPLS label: none
route-views>show bgp 109.167.136.174
BGP routing table entry for 109.167.128.0/18, version 8225448
Paths: (20 available, best #5, table default)
  Not advertised to any peer
  Refresh Epoch 1
  3561 209 3356 9002 9002 9002 9002 9002 9049 25408
    206.24.210.80 from 206.24.210.80 (206.24.210.80)
      Origin IGP, localpref 100, valid, external
      path 7F2BB636AC88 RPKI State valid
      rx pathid: 0, tx pathid: 0
  Refresh Epoch 1
  3267 9049 25408
    194.85.40.15 from 194.85.40.15 (185.141.126.1)
      Origin IGP, metric 0, localpref 100, valid, external
      path 7F2BB4C35D78 RPKI State valid
      rx pathid: 0, tx pathid: 0
  Refresh Epoch 1
  19214 174 1299 25408
    208.74.64.40 from 208.74.64.40 (208.74.64.40)
      Origin IGP, localpref 100, valid, external
      Community: 174:21000 174:22013
      path 7F2C136A7FD0 RPKI State valid
      rx pathid: 0, tx pathid: 0
  Refresh Epoch 1
  20912 3257 1299 25408
    212.66.96.126 from 212.66.96.126 (212.66.96.126)
      Origin IGP, localpref 100, valid, external
      Community: 3257:8066 3257:30055 3257:50001 3257:53900 3257:53902 20912:65004
      path 7F2C646D1408 RPKI State valid
      rx pathid: 0, tx pathid: 0
  Refresh Epoch 1
  7018 1299 25408
    12.0.1.63 from 12.0.1.63 (12.0.1.63)
      Origin IGP, localpref 100, valid, external, best
      Community: 7018:5000 7018:37232
      path 7F2C3B355A28 RPKI State valid
      rx pathid: 0, tx pathid: 0x0
  Refresh Epoch 1
  101 174 1299 25408
    209.124.176.223 from 209.124.176.223 (209.124.176.223)
      Origin IGP, localpref 100, valid, external
      Community: 101:20100 101:20110 101:22100 174:21000 174:22013
      Extended Community: RT:101:22100
      path 7F2C33F53ED0 RPKI State valid
      rx pathid: 0, tx pathid: 0
  Refresh Epoch 1
```
2. Создайте dummy0 интерфейс в Ubuntu. Добавьте несколько статических маршрутов. Проверьте таблицу маршрутизации.
Создадим dummy0-интерфейс:

```bash
root@ubuntu:~# lsmod | grep dummy
dummy                  16384  0
root@ubuntu:~# sudo ip link add dummy0 type dummy
root@ubuntu:~# sudo ip addr add 10.0.0.2/24 dev dummy0
root@ubuntu:~# sudo ip link set dummy0 up
root@ubuntu:~# ip address show

3: dummy0: <BROADCAST,NOARP,UP,LOWER_UP> mtu 1500 qdisc noqueue state UNKNOWN group default qlen 1000
    link/ether ca:b4:83:5d:e5:66 brd ff:ff:ff:ff:ff:ff
    inet 10.0.0.2/24 scope global dummy0
       valid_lft forever preferred_lft forever
    inet6 fe80::c8b4:83ff:fe5d:e566/64 scope link 
       valid_lft forever preferred_lft forever
```

Добавим маршруты и проверим таблицу маршрутизации:

```bash
root@ubuntu:~# ip route
default via 192.168.6.2 dev ens33 proto dhcp metric 100 
10.0.0.0/24 dev dummy0 proto kernel scope link src 10.0.0.2 
169.254.0.0/16 dev ens33 scope link metric 1000 
192.168.6.0/24 dev ens33 proto kernel scope link src 192.168.6.128 metric 100 
root@ubuntu:~# ip route add 188.242.0.0/15 dev dummy0
root@ubuntu:~# ip route
default via 192.168.6.2 dev ens33 proto dhcp metric 100 
10.0.0.0/24 dev dummy0 proto kernel scope link src 10.0.0.2 
169.254.0.0/16 dev ens33 scope link metric 1000 
188.242.0.0/15 dev dummy0 scope link 
192.168.6.0/24 dev ens33 proto kernel scope link src 192.168.6.128 metric 100
```

---
3. Проверьте открытые TCP порты в Ubuntu, какие протоколы и приложения используют эти порты? Приведите несколько примеров.

```bash
root@ubuntu:~# ss -tpan
State      Recv-Q  Send-Q          Local Address:Port        Peer Address:Port  Process                                                                         
LISTEN     0       4096            127.0.0.53%lo:53               0.0.0.0:*      users:(("systemd-resolve",pid=861,fd=13))                                      
LISTEN     0       128                   0.0.0.0:22               0.0.0.0:*      users:(("sshd",pid=1047,fd=3))                                                 
LISTEN     0       5                   127.0.0.1:631              0.0.0.0:*      users:(("cupsd",pid=1093,fd=7))                                                
ESTAB      0       0               192.168.6.128:39906     104.16.249.249:443    users:(("firefox",pid=3232,fd=94))                                             
TIME-WAIT  0       0               192.168.6.128:38670     34.160.144.191:443                                                                                   
ESTAB      0       0               192.168.6.128:36434       34.117.65.55:443    users:(("firefox",pid=3232,fd=124))                                            
TIME-WAIT  0       0               192.168.6.128:53966     35.244.181.201:443                                                                                   
TIME-WAIT  0       0               192.168.6.128:44190     34.120.208.123:443                                                                                   
LISTEN     0       4096       [::ffff:127.0.0.1]:63342                  *:*      users:(("java",pid=3302,fd=82))                                                
LISTEN     0       128                      [::]:22                  [::]:*      users:(("sshd",pid=1047,fd=4))                                                 
LISTEN     0       5                       [::1]:631                 [::]:*      users:(("cupsd",pid=1093,fd=6)) 
```
Порты : 
* 22 - ssh
* 53 - DNS
* 631 - CUPS

---
4. Проверьте используемые UDP сокеты в Ubuntu, какие протоколы и приложения используют эти порты?
```bash
root@ubuntu:~# ss -upan
State          Recv-Q         Send-Q                       Local Address:Port                     Peer Address:Port         Process                                            
UNCONN         0              0                                  0.0.0.0:43223                         0.0.0.0:*             users:(("avahi-daemon",pid=914,fd=14))            
UNCONN         0              0                            127.0.0.53%lo:53                            0.0.0.0:*             users:(("systemd-resolve",pid=861,fd=12))         
ESTAB          0              0                      192.168.6.128%ens33:68                      192.168.6.254:67            users:(("NetworkManager",pid=921,fd=23))          
UNCONN         0              0                                  0.0.0.0:631                           0.0.0.0:*             users:(("cups-browsed",pid=1013,fd=7))            
UNCONN         0              0                                  0.0.0.0:5353                          0.0.0.0:*             users:(("avahi-daemon",pid=914,fd=12))            
UNCONN         0              0                                     [::]:41519                            [::]:*             users:(("avahi-daemon",pid=914,fd=15))            
UNCONN         0              0                                     [::]:5353                             [::]:*             users:(("avahi-daemon",pid=914,fd=13)) 
```
Порты :
* 53 - DNS
* 43223 - Avahi Daemon
* 68 - Network Manager 
___
5. Используя diagrams.net, создайте L3 диаграмму вашей домашней сети или любой другой сети, с которой вы работали.



