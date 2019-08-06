# v2ray-mac-doh

此方案是在[v2ray-mac](/felix-fly/v2ray-mac)基础上改进而来的，加入了dnsmasq及doh，将任务进行拆分，dnsmasq处理解析及广告屏蔽，doh预防污染，v2ray只处理流量转送。

## 安装及配置dnsmasq
```shell
brew install dnsmasq
```
```shell
vi /usr/local/etc/dnsmasq.conf
```
```shell
port=53
server=ISP_DNS
listen-address=0.0.0.0
no-resolv
conf-dir=/path-to-dnsmasq-config/,*.hosts
cache-size=1000
```
修改**ISP_DNS**为当地DNS或者其他公共DNS地址，修改conf-dir指向ad.hosts和gw.hosts文件所在目录
```shell
brew services restart dnsmasq
```

## doh配置

mac上可以通过安装cloudflared来实现doh client的功能

[官方安装文档](https://developers.cloudflare.com/1.1.1.1/dns-over-https/cloudflared-proxy/)

```shell
curl https://bin.equinox.io/c/VdrWdbjqyF/cloudflared-stable-darwin-amd64.tgz | tar xzC /usr/local/bin
```
```shell
mkdir -p /usr/local/etc/cloudflared
cat << EOF > /usr/local/etc/cloudflared/config.yml
proxy-dns: true
proxy-dns-port: 1053
proxy-dns-upstream:
 - https://1.1.1.1/dns-query
EOF
```
此处**1.1.1.1**为上级dns地址，可以使用红鱼提供的，替换即可
* 东亚: ea-dns.rubyfish.cn
* 美国西部: uw-dns.rubyfish.cn
建议使用自建的，和v2ray同server可以享受到cdn加速的效果
```shell
sudo cloudflared service install
```

测试下解析是否正确

> dig +short @127.0.0.1 cloudflare.com AAAA
> 2400:cb00:2048:1::c629:d6a2
> 2400:cb00:2048:1::c629:d7a2

正确的话就可以启动v2ray了

```shell
./start.sh
```

配置v2ray开机自启动可以参考[v2ray-mac](/felix-fly/v2ray-mac)，不再重复。
