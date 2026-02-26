# Use the official Microsoft Playwright image as a base
FROM mcr.microsoft.com/playwright:v1.49.1-jammy

# PREVENT THE TIMEZONE HANG
ENV DEBIAN_FRONTEND=noninteractive

# Update and install basic tools
RUN apt-get update && apt-get install -y \
    curl \
    ca-certificates \
    openssl \
    git \
    sqlite3 \
    fontconfig \
    tzdata \
    iproute2 \
    libsqlite3-dev \
    && apt-get clean # Good practice to keep the image small

# Create the Pterodactyl user
RUN useradd -d /home/container -m container

USER container
ENV USER=container HOME=/home/container
WORKDIR /home/container

# Copy the entrypoint script
COPY ./entrypoint.sh /entrypoint.sh
# Note: Ensure entrypoint.sh is in the same folder as this Dockerfile
CMD ["/bin/bash", "/entrypoint.sh"]