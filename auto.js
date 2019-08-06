function parseDomain(host) {
  if (!host) return [];
  var list = [];
  var arr = host.split(".");
  while (arr.length >= 2) {
    list.push(arr.join("."));
    arr = arr.slice(1);
  }
  return list;
}
function FindProxyForURL(url, host) {
  var domains = parseDomain(host);
  for (var i = 0; i < domains.length; i++) {
    if (proxyMap[domains[i]])
      return "SOCKS5 127.0.0.1:12345;SOCKS 127.0.0.1:12345;";
  }
  return "DIRECT";
}