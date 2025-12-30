FROM debian:trixie-slim@sha256:4bcb9db66237237d03b55b969271728dd3d955eaaa254b9db8a3db94550b1885

RUN apt update \
    && apt install -y apt-transport-https dirmngr p7zip-full curl gnupg ca-certificates wget \
    && wget https://packages.microsoft.com/config/debian/13/packages-microsoft-prod.deb -O packages-microsoft-prod.deb \
    && dpkg -i packages-microsoft-prod.deb \
    && rm packages-microsoft-prod.deb \
    && apt-get update && apt-get install -y dotnet-sdk-9.0 dotnet-sdk-8.0 \
    && rm -rf /var/lib/apt/lists/*

RUN mkdir -pm755 /etc/apt/keyrings \
    && dpkg --add-architecture i386 \
    && wget -O - https://dl.winehq.org/wine-builds/winehq.key | gpg --dearmor -o /etc/apt/keyrings/winehq-archive.key - \
    && wget -NP /etc/apt/sources.list.d/ https://dl.winehq.org/wine-builds/debian/dists/trixie/winehq-trixie.sources \
    && apt update \
    && apt-get install -y --install-recommends winehq-stable

RUN wget -qO- https://monogame.net/downloads/net9_mgfxc_wine_setup.sh | bash

