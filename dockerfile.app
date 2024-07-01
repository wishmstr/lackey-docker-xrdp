FROM ghcr.io/lackeyforall/docker-base-image:latest

RUN dpkg --add-architecture i386 && apt-get update && apt-get install -y wine32:i386

RUN apt install -y rsyslog x11-apps vim winetricks xfce4-power-manager xfce4-terminal x11-xserver-utils

#Install OpenGL
RUN apt-get install -y libglu1-mesa-dev mesa-common-dev sudo freeglut3-dev


#Install ALSA
#RUN apt-get install -y -f libasound2t64 liboss4-salsa-asound2 alsa-utils alsa-oss

#Install PulseAudio Server
RUN apt-get install -y pulseaudio pulseaudio-utils

RUN systemctl enable rsyslog

WORKDIR /app

COPY src /app

COPY entrypoint.sh /app/entrypoint.sh

COPY opengltest /app/opengltest

RUN addgroup --system app
RUN adduser --home /app --ingroup app app
RUN chown -R app:app /app

#Set group membership for PulseAudio
RUN usermod -aG pulse,pulse-access app

USER app

RUN curl -LO https://lackeyccg.com/LackeyCCGWin.zip
RUN unzip LackeyCCGWin.zip -d .
RUN chmod -R 755 LackeyCCG

ENV USER=root
ENV DISPLAY=:0

ENTRYPOINT [ "/app/entrypoint.sh" ]
