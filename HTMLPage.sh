#!/bin/bash
echo "<meta http-equiv=\"X-Vay-Entropy\" content=\"$(cat /proc/sys/kernel/random/entropy_avail)\"/>" > /web/nginx/html/index.html

echo "<meta http-equiv=\"X-Vay-Load\" content=\"$(uptime | awk '{print $10}' |  tr -d ',')\"/> " >> /web/nginx/html/index.html

echo "<table><tbody><tr>" >> /web/nginx/html/index.html

NginxCompleTimeVersion=$(/nginx/objs/nginx  -V 2>&1)
echo "<td>the built nginx's version and compile-time option</td><td>$NginxCompleTimeVersion</td>" >> /web/nginx/html/index.html
echo "</tr><tr>" >> /web/nginx/html/index.html
AvgLoad=$(uptime | awk '{print $10}' |  tr -d ',')
echo "<td>system's load average after compiling nginx</td><td>$AvgLoad</td>" >> /web/nginx/html/index.html
echo "</tr><tr>" >> /web/nginx/html/index.html
SSLCert=$(openssl s_client -showcerts -connect let.me.play:10443 < /dev/null  2> /dev/null | openssl x509 -noout -enddate)
echo "<td>human-readable form of the SSL certificate used to serve the page over HTTPS</td><td>$SSLCert</td>" >> /web/nginx/html/index.html
echo "</tr><tr>" >> /web/nginx/html/index.html
Entropy=$(cat /proc/sys/kernel/random/entropy_avail)
echo "<td>entropy</td><td>$Entropy</td>" >> /web/nginx/html/index.html
echo "</tr><tr>" >> /web/nginx/html/index.html
KernelModules=$(cat /proc/modules)
echo "<td>KernelModules</td><td>$KernelModules</td>" >> /web/nginx/html/index.html
echo "</tr><tr>" >> /web/nginx/html/index.html
echo "</tbody> </table> " >> /web/nginx/html/index.html


