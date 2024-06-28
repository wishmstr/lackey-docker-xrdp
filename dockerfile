FROM ubuntu:latest

#RUN dpkg --add-architecture i386 && \
#    apt-get update && \
#    apt-get install -y software-properties-common wget && \
#    wget -nc https://dl.winehq.org/wine-builds/winehq.key && \
#    apt-key add winehq.key && \
#    add-apt-repository 'deb https://dl.winehq.org/wine-builds/ubuntu/ focal main' && \
#    apt-get update

RUN apt-get update && apt-get install -y \
    curl \
    wine \
#    wine32:i386 \
#    winetricks \
    net-tools \
    unzip \
    xfce4 \
    xfce4-goodies \
    tightvncserver

RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

#ENV WINEARCH=win32

#RUN wineboot --init

WORKDIR /app

RUN curl -LO https://lackeyccg.com/LackeyCCGWin.zip
RUN unzip LackeyCCGWin.zip -d .
RUN chmod -R 755 LackeyCCG

COPY entrypoint.sh /app/entrypoint.sh

RUN mkdir -p /nonexistent /wineprefix
RUN addgroup --system app
RUN adduser --system --ingroup app app
RUN chown -R app:app /nonexistent /wineprefix

USER app

ENV USER=root
ENV PASSWORD=asdfasdf

RUN mkdir -p ~/.vnc && \
    echo "$PASSWORD" | vncpasswd -f > ~/.vnc/passwd && \
    chmod 600 ~/.vnc/passwd

RUN echo '#!/bin/bash\n' \
    'xrdb $HOME/.Xresources\n' \
    'startxfce4 &' > ~/.vnc/xstartup && \
    chmod +x ~/.vnc/xstartup

ENTRYPOINT [ "/app/entrypoint.sh" ]
