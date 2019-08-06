#!/bin/sh

# wget -O ad.hosts https://raw.githubusercontent.com/felix-fly/v2ray-dnsmasq-dnscrypt/master/ad.hosts
# wget -O gw https://raw.githubusercontent.com/felix-fly/v2ray-dnsmasq-dnscrypt/master/gw.hosts

# sed -e '/ipset=/d' gw > gw.hosts
# rm gw

# generate auto.pac file
echo "var proxyMap = {" > auto.pac
cat gw.hosts | awk -F/ '{printf("\"%s\":true,\n",$2)}' >> auto.pac
echo "};" >> auto.pac
cat auto.js >> auto.pac
