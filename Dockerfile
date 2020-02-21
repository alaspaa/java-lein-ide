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
 apt-get install wget -y && \
 apt-get install curl -y && \
 apt-get install gnupg -y && \ 
 apt-get install scala -y 
#WGET
RUN wget -O /usr/bin/lein https://raw.githubusercontent.com/technomancy/leiningen/stable/bin/lein && \
 (chmod a+x /usr/bin/lein) && \
 lein
RUN wget https://github.com/cdr/code-server/releases/download/2.1698/code-server2.1698-vsc1.41.1-linux-x86_64.tar.gz && \
 tar -xzvf code-server2.1698-vsc1.41.1-linux-x86_64.tar.gz && \
 chmod +x code-server2.1698-vsc1.41.1-linux-x86_64/code-server
#SBT
RUN echo "deb https://dl.bintray.com/sbt/debian /" | tee -a /etc/apt/sources.list.d/sbt.list 
RUN curl -sL "https://keyserver.ubuntu.com/pks/lookup?op=get&search=0x2EE0EA64E40A89B84B2DF73499E82A75642AC823" | apt-key add
RUN apt-get update -y && \
 apt-get install sbt -y
#CLEAN UP
RUN rm -rf code-server2.1698-vsc1.41.1-linux-x86_64.tar.gz && \
 apt-get remove wget -y && \
 apt-get remove wget -y && \
 apt-get autoremove -y

ENTRYPOINT ["docker-entrypoint"]
