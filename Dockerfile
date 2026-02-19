FROM eclipse-temurin:25-jdk

# Install Chromium dependencies
RUN apt-get update -y \
    && apt-get install -y \
        lsof curl ca-certificates openssl git tar sqlite3 fontconfig libfreetype6 tzdata iproute2 libstdc++6 \
        libglib2.0-0 libnss3 libatk1.0-0 libatk-bridge2.0-0 libcups2 libdrm2 libgtk-3-0 libgbm1 libasound2t64 \
        fonts-liberation libxss1 libx11-6 libxi6 libxrender1 libxtst6 libxcomposite1 libxcursor1 libxxf86vm1 \
        xvfb libxdamage1 libxrandr2 libxext6 libxfixes3 libpango-1.0-0 libpangocairo-1.0-0 libcairo2 libexpat1 \
    && rm -rf /var/lib/apt/lists/* \
    && useradd -d /home/container -m container

USER container
ENV USER=container HOME=/home/container
WORKDIR /home/container

COPY entrypoint.sh /entrypoint.sh
CMD [ "/bin/bash", "/entrypoint.sh" ]