FROM ubuntu:16.04

ENV DEBIAN_FRONTEND=noninteractive

# ----- DEPENDENCIAS D2GS + WINE + PVPGN -----
RUN dpkg --add-architecture i386 && \
  apt-get update && \
  apt-get install -y --no-install-recommends \
  make \
  wget \
  curl \
  git \
  cmake \
  tar \
  flex \
  bison \
  xz-utils \
  unzip \
  build-essential \
  lib32z1 \
  lib32ncurses5 \
  gcc-multilib \
  g++-multilib \
  zlib1g-dev \
  liblua5.1-0-dev \
  mysql-server \
  mysql-client \
  libmysqlclient-dev \
  xserver-xorg-dev:i386 \
  libfreetype6-dev:i386 \
  libx11-dev:i386 \
  vim \
  libxext-dev:i386 && \
  rm -rf /var/lib/apt/lists/*

# ----- COMPILAR WINE 2.0.1 CON SOCK.C -----
WORKDIR /home
RUN wget http://dl.winehq.org/wine/source/2.0/wine-2.0.1.tar.xz && \
    tar xf wine-2.0.1.tar.xz && rm wine-2.0.1.tar.xz && \
    wget --no-check-certificate https://gist.githubusercontent.com/HarpyWar/cd3676fa4916ea163c50/raw/50fbbff9a310d98496f458124fac14bda2e16cf0/sock.c && \
    mv sock.c wine-2.0.1/server && \
    mkdir wine-dirs && mv wine-2.0.1 wine-dirs/wine-source && \
    mkdir wine-dirs/wine-build

WORKDIR /home/wine-dirs/wine-build
RUN ../wine-source/configure --without-x && \
    make -j$(nproc) && \
    make install -j$(nproc)

# ----- INSTALAR D2GS -----
WORKDIR /home
RUN wget --no-check-certificate https://github.com/pvpgn/pvpgn-magic-builder/archive/v2.29.tar.gz && \
    tar xf v2.29.tar.gz && \
    mv pvpgn-magic-builder-2.29/module/include/d2gs/1.13d d2gs

COPY conf/d2gs.reg /home/d2gs/
COPY conf/start.sh /home/d2gs/

# Config inicial de Wine (puede fallar en headless)
RUN winecfg || true

WORKDIR /home/d2gs
RUN set -e && \
  wget -nv http://cdn.pvpgn.pro/diablo2/1.13d/D2Client.dll && \
  wget -nv http://cdn.pvpgn.pro/diablo2/1.13d/D2CMP.dll && \
  wget -nv http://cdn.pvpgn.pro/diablo2/1.13d/D2Common.dll && \
  wget -nv http://cdn.pvpgn.pro/diablo2/1.13d/D2Game.dll && \
  wget -nv http://cdn.pvpgn.pro/diablo2/1.13d/D2gfx.dll && \
  wget -nv http://cdn.pvpgn.pro/diablo2/1.13d/D2Lang.dll && \
  wget -nv http://cdn.pvpgn.pro/diablo2/1.13d/D2MCPClient.dll && \
  wget -nv http://cdn.pvpgn.pro/diablo2/1.13d/D2Net.dll && \
  wget -nv http://cdn.pvpgn.pro/diablo2/1.13d/D2sound.dll && \
  wget -nv http://cdn.pvpgn.pro/diablo2/1.13d/D2Win.dll && \
  wget -nv http://cdn.pvpgn.pro/diablo2/1.13d/Fog.dll && \
  wget -nv http://cdn.pvpgn.pro/diablo2/1.13d/Storm.dll && \
  wget -nv http://cdn.pvpgn.pro/diablo2/1.14d/Patch_D2.mpq && \
  wget -nv http://cdn.pvpgn.pro/diablo2/1.14d/ijl11.dll && \
  wget -nv http://cdn.pvpgn.pro/diablo2/d2speech.mpq && \
  wget -nv http://cdn.pvpgn.pro/diablo2/d2data.mpq && \
  wget -nv http://cdn.pvpgn.pro/diablo2/d2sfx.mpq && \
  wget -nv http://cdn.pvpgn.pro/diablo2/d2exp.mpq && \
  mv /home/d2gs /root/.wine/drive_c/d2gs

WORKDIR /root/.wine/drive_c/d2gs
RUN chmod +x ./start.sh

WORKDIR /
COPY start.sh /start.sh
RUN chmod +x /start.sh

# ----- COMPILAR PVPGN 1.99.7.2.1 -----
WORKDIR /root
RUN wget --no-check-certificate https://github.com/pvpgn/pvpgn-server/archive/1.99.7.2.1.tar.gz && \
    tar xf 1.99.7.2.1.tar.gz && \
    rm 1.99.7.2.1.tar.gz && \
    cd pvpgn-server-1.99.7.2.1 && \
    mkdir build

WORKDIR /root/pvpgn-server-1.99.7.2.1/build
RUN cmake -D CMAKE_INSTALL_PREFIX=/pvpgn -D WITH_MYSQL=true -D WITH_LUA=true ../ && \
    make -j$(nproc) && make install

WORKDIR /
COPY .env /env
COPY configFiles.sh /configFiles.sh
RUN chmod +x /configFiles.sh && /configFiles.sh


ENTRYPOINT ["/start.sh"]
