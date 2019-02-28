#!/bin/bash
outfile="/tmp/sysinfo-$(date +\%s).html"
echo "<!DOCTYPE html>
<head>
<meta charset="UTF-8"/>
<title>System information `uname -n` at `date +"%d-%m-%Y %T"`</title>
</head>
<body>
<table>" > $outfile
systitle=`uname -sorn`
system=`uname -a`
uptime=`uptime`
release=`cat /etc/*release*`
cpu1=`cat /proc/cpuinfo | grep 'vendor' | uniq`
cpu2=`cat /proc/cpuinfo | grep 'model name' | uniq`
cpu3=`cat /proc/cpuinfo | grep processor | wc -l`
cpu4=`cat /proc/cpuinfo | grep 'core id'`
free=`free -m`
disk=`df -m`
bootmsg=`dmesg | grep error`
echo "<H1>$systitle</H1>
      <tr><td bgcolor=#F8E0E6>$system</td></tr>
      <tr><td bgcolor=#F8E0E0>$uptime</td></tr>
      <tr><td bgcolor=#F8E6E0><pre>$release</pre></td></tr>
      <tr><td bgcolor=#F8ECE0>CPU Information:<br>$cpu1,$cpu2,$cpu3,$cpu4</td></tr>
      <tr><td bgcolor=#F7F2E0>Memory Disk Resource:<br><pre>$free</pre><br><pre>$disk</pre></td></tr>
      <tr><td bgcolor=#F7F8E0>Boot Messages(errors)<br><pre>$bootmsg</pre></td></tr>" >> $outfile
if [ -e /var/log/syslog ]; then
  syslog=`tail -25 /var/log/syslog`
  echo "<tr><td bgcolor=#F1F8E0>SYSLOG:/var/log/syslog<br><pre>$syslog</pre></td></tr>" >> $outfile
fi
if [ -e /var/log/messages ]; then
  messages=`tail -25 /var/log/messages`
  echo "<tr><td bgcolor=#ECF8E0>SYSLOG:/var/log/messages<br><pre>$messages</pre></td></tr>" >> $outfile
fi
devices=`lspci`
echo "<tr><td bgcolor=#E6F8E0>PCI Device list<br><pre>$devices</pre></td></tr>" >> $outfile
if [ -e /usr/bin/inxi ]
then 
   sum=`inxi -b -c 0`
   echo "<tr><td bgcolor=#E0F8E0>System Summary Information:<br><pre>$sum</pre></td></tr>" >> $outfile
else
   echo "inxi not found"
fi
modules=`lsmod`
echo "<tr><td bgcolor=#E0F8E6>Kernel modules information<br><pre>$modules</pre></td></tr>" >> $outfile
if [ -e /etc/network/interfaces ]; then
  interfaces=`cat /etc/network/interfaces`
  echo "<tr><td bgcolor=#E0F8EC>Network interfaces Debian<br><pre>$interfaces</pre></td></tr>" >> $outfile
fi
if [ -d /etc/sysconfig/network-scripts ]; then
  ifcfgfiles=`ls -al /etc/sysconfig/network-scripts/`
  netscripts=`cat /etc/sysconfig/network-scripts/ifcfg*`
  echo "<tr><td bgcolor=#E0F8F1>Network interfaces Red Hat<br><pre>$ifcfgfiles $netscripts</pre></td></tr>" >> $outfile
fi
if [ -d /etc/netplan ]; then
  yamlfiles=`ls -al /etc/netplan/`
  yaml=`cat /etc/netplan/*`
  echo "<tr><td bgcolor=#E0F8F7>Network interfaces ubuntu yaml<br><pre>$yamlfiles $yaml</pre></td></tr>" >> $outfile
fi
if [ -e /sbin/ifconfig ]; then
  ifconfigold=`ifconfig`
  echo "<tr><td bgcolor=#E0F2F7>Network ifconfig<br><pre>$ifconfigold</pre></td></tr>" >> $outfile
fi
ifconfig=`ip addr show`
echo "<tr><td bgcolor=#E0ECF8>Network ip addr show<br><pre>$ifconfig</pre></td></tr>" >> $outfile
ip1=`ip -4 addr | grep -oP '(?<=inet\s)\d+(\.\d+){3}'`
echo "<tr><td bgcolor=#E0E6F8>IPv4 network information<br><pre>$ip1</pre></td></tr>" >> $outfile
ip2=`ip -6 addr | grep -oP '(?<=inet6\s)[\da-f:]+'`
echo "<tr><td bgcolor=#E0E6F8>IPv6 network information<br><pre>$ip2</pre></td></tr>" >> $outfile
route1=`netstat -r`
echo "<tr><td bgcolor=#E0E0F8>Routing table netstat -r<br><pre>$route1</pre></td></tr>" >> $outfile
route2=`ip route show`
echo "<tr><td bgcolor=#E6E0F8>Routing ip route show<br><pre>$route2</pre></td></tr>" >> $outfile
hosts=`cat /etc/hosts`
echo "<tr><td bgcolor=#ECE0F8>DNS Resolver:/etc/hosts<br><pre>$hosts</pre></td></tr>" >> $outfile
host=`cat /etc/host.conf`
echo "<tr><td bgcolor=#F2E0F7>DNS Resolver:/etc/host.conf<br><pre>$host</pre></td></tr>" >> $outfile
resolv=`cat /etc/resolv.conf`
echo "<tr><td bgcolor=#F8E0F7>DNS Resolver:/etc/resolv.conf<br><pre>$resolv</pre></td></tr>" >> $outfile
extip=`curl -L ipline.ch/echo`
echo "<tr><td bgcolor=#F8E0F1>External ip address: $extip</td></tr>" >> $outfile
ping1=`ping -c3 -4 time.google.com`
echo "<tr><td bgcolor=#F8E0EC>Ping time.google.com<br><pre>$ping1</pre></td></tr>" >> $outfile
ping2=`ping6 ipv6.google.com`
echo "<tr><td bgcolor=#F8E0E6>Ping6 ipv6.google.com<br><pre>$ping2</pre></td></tr>" >> $outfile
echo "</table></body>" >> $outfile