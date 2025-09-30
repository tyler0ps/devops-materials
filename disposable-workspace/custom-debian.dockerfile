FROM debian:stable

RUN apt-get update && \
    apt-get install -y \
        curl \
        ca-certificates \
        git \
        vim \
        zsh && \
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

RUN apt-get install -y zsh-syntax-highlighting && \
    echo "source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" >> /root/.zshrc
    
COPY robbyrussell.zsh-theme /root/.oh-my-zsh/themes/robbyrussell.zsh-theme
