FROM ubuntu:18.04

RUN apt-get update && apt-get install -y apt-transport-https wget vim cron iputils-ping libssl-dev build-essential openssl libaio-dev libaio1 git make
#RUN apt-get install -y  libssl-dev mod_ssl openssl libaio
RUN git clone https://github.com/nginx/nginx.git


RUN cd nginx; git checkout 285a495d ; git reset --hard HEAD
#RUN cd nginx; git reset --hard HEAD
RUN cd nginx; ./auto/configure --prefix=/web/nginx --modules-path=/web/nginx/modules --with-http_ssl_module  --without-http_fastcgi_module --without-http_uwsgi_module --without-http_grpc_module --without-http_scgi_module --without-mail_imap_module --without-mail_pop3_module  --without-http_rewrite_module --without-http_gzip_module --with-file-aio ; sleep 1 ; make ; sleep 1 ; make install 
RUN mkdir /nginx/conf/cert/
COPY ./HTMLPage.sh /HTMLPage.sh
#COPY ./startprocesses.sh /startprocesses.sh
COPY ./let.me.play.key /nginx/conf/cert/let.me.play.key
COPY ./let.me.play.csr /nginx/conf/cert/let.me.play.csr
COPY ./newnginx.conf /web/nginx/conf/nginx.conf
#COPY ./nginx.conf /nginx/conf/nginx.conf

RUN chmod 0755 /HTMLPage.sh 

RUN crontab -l | { cat; echo "* * * * * sh /HTMLPage.sh"; } | crontab -

#CMD cron


#RUN echo "127.0.0.1         let.me.play" >> /etc/hosts
#RUN /nginx/objs/nginx 
# Run the command on container startup
#RUN /startprocesses.sh &
#RUN /nginx/objs/nginx  -c /nginx/conf/nginx.conf 

#openssl req –new –newkey rsa:2048 –nodes –keyout let.me.play.key –out let.me.play.csr

#openssl req -new -newkey rsa:2048 -nodes -keyout let.me.play.key -out let.me.play.pem

#openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout let.me.play.key -out let.me.play.csr


# /nginx/objs/nginx  -V

#server {
#    listen 80;
#    server_name let.me.play ;
#
#    location / {
#        proxy_set_header   X-Forwarded-For $remote_addr;
#        proxy_set_header   Host $http_host;
#        proxy_pass         "http://127.0.0.1:8080";
#    }
#}
#
#
##echo "<meta http-equiv=\"X-Vay-Entropy\" content=\"$(cat /proc/sys/kernel/random/entropy_avail)\"/>" > test.html
##
##echo "<meta http-equiv=\"X-Vay-Load\" content=\"$(uptime | awk '{print $10}' |  tr -d ',')\"/> " >> test.html
##
##echo "<table><tbody><tr>" >> test.html
##
##NginxCompleTimeVersion=$(/nginx/objs/nginx  -V 2>&1)
##echo "<td>the built nginx's version and compile-time option</td><td>$NginxCompleTimeVersion</td>" >> test.html
##echo "</tr><tr>" >> test.html
##AvgLoad=$(uptime | awk '{print $10}' |  tr -d ',')
##echo "<td>system's load average after compiling nginx</td><td>$AvgLoad</td>" >> test.html
##echo "</tr><tr>" >> test.html
##SSLCert=$(openssl s_client -showcerts -connect let.me.play:10443 < /dev/null  2> /dev/null | openssl x509 -noout -enddate)
##echo "<td>human-readable form of the SSL certificate used to serve the page over HTTPS</td><td>$SSLCert</td>" >> test.html
##echo "</tr><tr>" >> test.html
##Entropy=$(cat /proc/sys/kernel/random/entropy_avail)
##echo "<td>entropy</td><td>$Entropy</td>" >> test.html
##echo "</tr><tr>" >> test.html
##KernelModules=$(cat /proc/modules)
##echo "<td>KernelModules</td><td>$KernelModules</td>" >> test.html
##echo "</tr><tr>" >> test.html
##echo "</tbody> </table> " >> test.html
##

#echo "<td></td><td>$</td>" >> test.html


#$(uptime | awk '{print $10}' |  tr -d ',')