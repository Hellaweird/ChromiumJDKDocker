FROM eclipse-temurin:21-jdk-jammy

# 1. Update and install basic tools
RUN apt-get update && apt-get install -y curl

# 2. Install Playwright dependencies (the heavy lifting)
# We use a dummy node install just to use the playwright CLI to fetch deps
RUN curl -fsSL https://deb.nodesource.com/setup_18.x | bash - && \
    apt-get install -y nodejs && \
    npx playwright install-deps && \
    apt-get purge -y nodejs && apt-get autoremove -y

# 3. Setup Pterodactyl's user environment
RUN useradd -d /home/container -m container
USER container
ENV USER=container HOME=/home/container
WORKDIR /home/container

COPY ./../entrypoint.sh /entrypoint.sh
CMD ["/bin/bash", "/entrypoint.sh"]