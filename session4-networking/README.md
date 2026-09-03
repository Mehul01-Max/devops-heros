# Session 4: Networking Commands

## `curl https://www.example.com`

Fetches data from a URL and, with `-I`, displays the response headers.

![curl output](images/curl.png)

## `ip addr`

Displays the network interfaces, IP addresses, MAC addresses, and interface status.

![ip addr output](images/ip_addr.png)

## `nslookup google.com`

Queries DNS to find the IP addresses associated with a domain name.

![nslookup output](images/nslookup.png)

## `ping 8.8.8.8`

Tests network reachability and measures the response time to a destination.

![ping output](images/ping.png)

## `ss -tuln`

Lists listening TCP and UDP network sockets with numeric addresses and ports.

![ss -tuln output](images/ss_-tuln.png)

## `telnet google.com 80`

Tests whether a TCP connection can be established to a host and port.

![telnet output](images/telnet.png)

## `traceroute google.com`

Shows the network hops and response times between the local machine and a destination.

![traceroute output](images/traceroute.png)
