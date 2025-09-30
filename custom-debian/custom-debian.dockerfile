FROM debian:stable

RUN apt-get update && \
    apt-get install -y \
        curl \
        ca-certificates \
        git \
        zsh && \
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
