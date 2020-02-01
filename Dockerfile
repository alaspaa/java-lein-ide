FROM debian:bullseye-slim
#SETUP
ADD ./code /code
ADD ./data /data
ADD ./docker-entrypoint.sh /usr/bin/docker-entrypoint
RUN (chmod a+x /usr/bin/docker-entrypoint) && \
 mkdir -p /usr/share/man/man1
#APT GET
RUN apt-get update -y && \
 apt-get install -y openjdk-11-jdk && \
 apt-get install wget -y
#WGET
RUN wget -O /usr/bin/lein https://raw.githubusercontent.com/technomancy/leiningen/stable/bin/lein && \
 (chmod a+x /usr/bin/lein) && \
 lein
RUN wget https://github.com/cdr/code-server/releases/download/2.1698/code-server2.1698-vsc1.41.1-linux-x86_64.tar.gz && \
 tar -xzvf code-server2.1698-vsc1.41.1-linux-x86_64.tar.gz && \
 chmod +x code-server2.1698-vsc1.41.1-linux-x86_64/code-server
#CLEAN UP
RUN rm -rf code-server2.1698-vsc1.41.1-linux-x86_64.tar.gz && \
 apt-get remove wget -y && \
 apt-get remove wget -y && \
 apt-get autoremove -y

ENTRYPOINT ["docker-entrypoint"]
