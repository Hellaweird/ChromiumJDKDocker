FROM eclipse-temurin:25-jdk-jammy

RUN apt-get update && apt-get install -y curl && \
    curl -fsSL https://deb.nodesource.com/setup_18.x | bash - && \
    apt-get install -y nodejs && \
    npx playwright install-deps && \
    apt-get purge -y nodejs && apt-get autoremove -y && rm -rf /var/lib/apt/lists/*

RUN useradd -d /home/container -m container
USER container
ENV USER=container HOME=/home/container
WORKDIR /home/container

# Pterodactyl default entrypoint
COPY ./entrypoint.sh /entrypoint.sh
CMD ["/bin/bash", "/entrypoint.sh"]