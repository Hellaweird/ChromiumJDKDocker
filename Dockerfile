# Use the official Microsoft Playwright image as a base
# This contains all the OS-level dependencies (libgbm, libnss3, etc.)
FROM mcr.microsoft.com/playwright:v1.49.1-jammy

# Update and install basic tools needed for Pterodactyl
RUN apt-get update && apt-get install -y \
    curl \
    ca-certificates \
    openssl \
    git \
    sqlite3 \
    fontconfig \
    tzdata \
    iproute2 \
    libsqlite3-dev

# Create the Pterodactyl user
RUN useradd -d /home/container -m container

USER container
ENV USER=container HOME=/home/container
WORKDIR /home/container

# Copy the entrypoint script (provided by Pterodactyl)
COPY ./entrypoint.sh /entrypoint.sh
CMD ["/bin/bash", "/entrypoint.sh"]