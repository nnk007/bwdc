FROM debian:stable
WORKDIR /dc
RUN apt update
RUN apt install -y -qq wget unzip libsecret-1-0
RUN wget "https://bitwarden.com/download/?app=connector&platform=linux&variant=cli-zip" -O /tmp/dc.zip
RUN unzip /tmp/dc.zip -d /usr/local/bin
RUN rm /tmp/dc.zip
RUN mkdir -p /root/.config
# mount data.json to here
RUN ln -s /dc /root/.config/Bitwarden\ Directory\ Connector
# avoid dbus errors
RUN export BITWARDENCLI_CONNECTOR_PLAINTEXT_SECRETS=true
ENTRYPOINT ["/usr/local/bin/bwdc"]
CMD ["sync"]