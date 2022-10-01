####################################################################
## ZOUPA - (ZombyMediaIC open source usage protection agreement)  ##
## License as of: 01.10.2022 20:30 | #202210012030                ##
## Niklas Vorberg (AsP3X)                                         ##
####################################################################

FROM ubuntu:latest
LABEL org.opencontainers.image.authors="ZombyMediaIC"

RUN apt-get update
RUN apt-get upgrade -y

RUN echo "You can change this later"
ENV RAM="6G"

RUN apt-get install -y wget screen nano mysql-client dpkg tar net-tools unzip

RUN apt-get install openjdk-8-jdk -y
# RUN apt-get install openjdk-11-jdk -y

## Installing java16 as openjdk from java.net
# RUN mkdir /usr/lib/jvm
# RUN wget https://download.java.net/java/GA/jdk17.0.2/dfd4a8d0985749f896bed50d7138ee7f/8/GPL/openjdk-17.0.2_linux-x64_bin.tar.gz
# RUN tar -xvf openjdk-17.0.2_linux-x64_bin.tar.gz -C /usr/lib/jvm/
# RUN ln -s /usr/lib/jvm/jdk-17 /usr/lib/jvm/jdk-17.0.2
# RUN update-alternatives --install /usr/bin/java java /usr/lib/jvm/jdk-17.0.2/bin/java 100
# RUN update-alternatives --install /usr/bin/javac javac /usr/lib/jvm/jdk-17.0.2/bin/javac 100

# RUN update-alternatives --display java
# RUN update-alternatives --display javac

# Creating folderstructure for the server
RUN mkdir /temp
RUN mkdir /serverfiles

## Creating server
COPY forge-installer.jar /temp/
RUN chmod +x /temp/forge-installer.jar
RUN java -jar /temp/forge-installer.jar --installServer /serverfiles

# COPY ./serverfiles/config /temp/config
# COPY ./serverfiles/defaultconfigs /temp/defaultconfigs
# COPY ./serverfiles/mods /temp/mods
# COPY ./serverfiles/openloader /temp/openloader
# COPY ./serverfiles/scripts /temp/scripts
# COPY ./serverfiles/server-icon.png /temp/server-icon.png
# COPY ./serverfiles/server.properties /temp/server.properties
COPY ./start.sh /temp/start.sh

RUN wget https://nextcloud.corespace.de/s/LknkXQPEDjWeFcD/download/serverfiles.zip -o /temp/serverfiles.zip
RUN unzip /temp/serverfiles.zip -d /temp

RUN chmod +x /temp/start.sh

## Creating server directory for server creation process
WORKDIR /server

EXPOSE 25565
EXPOSE 25575

CMD ["/bin/bash","/temp/start.sh"]