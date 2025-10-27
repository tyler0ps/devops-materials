FROM debian:stable

RUN apt-get update && \
    apt-get install curl -y && \
    curl -s https://packagecloud.io/install/repositories/ookla/speedtest-cli/script.deb.sh | bash && \
    apt-get install speedtest -y

CMD [ "speedtest", "--accept-license" ]
