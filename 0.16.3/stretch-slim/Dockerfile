# Copyright (c) 2019 sunfjun

FROM debian:stretch-slim

ENV BCX_VERSION 0.16.3
ENV BCX_URL https://github.com/bitcoinx-project/bitcoinx/releases/download/v${BCX_VERSION}/bitcoinx-${BCX_VERSION}-x86_64-linux-gnu.tar.gz
ENV BCX_SHA256 ecc51f6facf6155275757fa4fc3f22472d10dcb3db9b36a08b3327a79b6947f5

ADD $BCX_URL /tmp/bitcoinx.tar.gz
RUN cd /tmp \
	&& echo "$BCX_SHA256  bitcoinx.tar.gz" | sha256sum -c - \
	&& tar -xzvf bitcoinx.tar.gz -C /usr/local --strip-components=1 --exclude=*-qt \
	&& rm bitcoinx.tar.gz

RUN addgroup bitcoinx && adduser --gecos "" --home /home/bitcoinx --disabled-password --ingroup bitcoinx bitcoinx
ENV BCX_DATA /data
RUN mkdir "$BCX_DATA" \
	&& chown -R bitcoinx:bitcoinx "$BCX_DATA" \
	&& ln -sfn "$BCX_DATA" /home/bitcoinx/.bitcoinx \
	&& chown -h bitcoinx:bitcoinx /home/bitcoinx/.bitcoinx
VOLUME /data

COPY 0.16.3/stretch-slim/entrypoint.sh /entrypoint.sh
RUN chmod 755 /entrypoint.sh
USER bitcoinx

EXPOSE 8332 8333 18332 18333

ENTRYPOINT ["/entrypoint.sh"]
CMD ["bitcoinxd"]
