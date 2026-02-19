FROM eclipse-temurin:25-jdk

# Install Chromium dependencies
RUN apt-get update && apt-get install -y \
    libglib2.0-0 \
    libnss3 \
    libatk1.0-0 \
    libatk-bridge2.0-0 \
    libcups2 \
    libdrm2 \
    libgtk-3-0 \
    libgbm1 \
    libasound2t64 \
    ca-certificates \
    fonts-liberation \
    libxss1 \
    libx11-6 \
    libxi6 \
    libxrender1 \
    libxtst6 \
    libxcomposite1 \
    libxcursor1 \
    libxdamage1 \
    libxrandr2 \
    libxext6 \
    libxfixes3 \
    libpango-1.0-0 \
    libpangocairo-1.0-0 \
    libcairo2 \
    libfontconfig1 \
    libfreetype6 \
    libexpat1 \
    libdbus-1-3 \
    lsb-release \
    xdg-utils \
    wget \
    && rm -rf /var/lib/apt/lists/*

RUN 				apt-get update -y \
						&& apt-get install -y lsof curl ca-certificates openssl git tar sqlite3 fontconfig libfreetype6 tzdata iproute2 libstdc++6 \
						&& useradd -d /home/container -m container
# Pterodactyl user setup
RUN useradd -d /home/container -m container
USER container
ENV USER=container HOME=/home/container
WORKDIR /home/container

# Note: Pterodactyl provides the entrypoint usually, but we can specify one if needed
COPY        ./../entrypoint.sh /entrypoint.sh
CMD         [ "/bin/bash", "/entrypoint.sh" ]