FROM ghcr.io/lackeyforall/docker-base-image:0.0.9

COPY src/etc /etc

RUN usermod -aG pulse,pulse-access app

RUN dpkg --add-architecture i386 && apt-get update && apt-get install wine32 -y

RUN apt-get install -y \
  pulseaudio-module-zeroconf \
  curl \
  git \
  python3-numpy \
  xfce4-goodies \
  xrdp

#
# Perform the rest of the commands as the app user.
#
WORKDIR /app

COPY entrypoint.sh /app/entrypoint.sh
COPY --chown=app:app src/app /app
COPY --chown=app:app opengltest /app/opengltest
COPY --chown=app:app .artifacts/LackeyCCG /app/LackeyCCG

# RUN wget --show-progress --progress=bar:force:noscroll -q  https://lackeyccg.com/LackeyCCGWin.zip
# RUN curl -LO https://lackeyccg.com/LackeyCCGWin.zip
# RUN unzip LackeyCCGWin.zip -d .

# TODO: Download noVNC tarball from https://github.com/novnc/noVNC here
RUN curl -LO https://github.com/novnc/noVNC/archive/refs/tags/v1.5.0.tar.gz
# TODO: Unpack noVNC tarball here
RUN tar -xvzf v1.5.0.tar.gz

#
# Set the entrypoint script that is run when the container starts.
#
ENTRYPOINT [ "/app/entrypoint.sh" ]
