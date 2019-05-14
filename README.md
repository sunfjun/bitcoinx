# sunfjun/bitcoinx

A BitcoinX-project docker image.

[![sunfjun/bitcoinx][https://hub.docker.com/r/sunfjun/bitcoinx]][docker-hub-url] [![sunfjun/bitcoinx][docker-stars-image]][docker-hub-url] [![sunfjun/bitcoinx][docker-size-image]][docker-hub-url] [![sunfjun/bitcoinx][docker-layers-image]][docker-hub-url]

## Tags

- `0.16.3-stretch-slim` ([0.16.3/stretch-slim/Dockerfile](https://github.com/sunfjun/bitcoinx/blob/master/0.16.3/stretch-slim/Dockerfile))

## What is BitcoinX? 

BitcoinX is an experimental digital currency that enables instant payments to anyone, anywhere in the world. BitcoinX uses peer-to-peer technology to operate with no central authority: managing transactions and issuing money are carried out collectively by the network. BitcoinX Core is the name of open source software which enables the use of this currency.

For more information, as well as an immediately useable, binary version of the BitcoinX Core software, see [BitcoinX](https://bcx.org).

## Usage

### How to use this image

This image contains the main binaries from the BitcoinX project - `bitcoinxd`, `bitcoinx-cli`. It behaves like a binary, so you can pass any arguments to the image and they will be forwarded to the `bitcoinxd` binary:

```sh
❯ docker run --rm -it sunfjun/bitcoinx \
  -printtoconsole \
  -regtest=1 \
  -rpcallowip=172.17.0.0/16 \
  -rpcpassword=bar \
  -rpcuser=foo
```

By default, `bitcoinxd` will run as user `bitcoinx` for security reasons and with its default data dir (`~/.bitcoinx/`). If you'd like to customize where `bitcoinx` stores its data, you must use the `BCX_DATA` environment variable. The directory will be automatically created with the correct permissions for the `bitcoinx` user and `bitcoinx` automatically configured to use it.

```sh
❯ docker run --env BCX_DATA=/var/lib/data --rm -it sunfjun/bitcoinx \
  -printtoconsole \
  -regtest=1
```

You can also mount a directory it in a volume under `/home/bitcoin/.bitcoinx` in case you want to access it on the host:

```sh
❯ docker run -v ${PWD}/data:/home/bitcoinx/.bitcoinx -it --rm sunfjun/bitcoinx \
  -printtoconsole \
  -regtest=1
```

You can optionally create a service using `docker-compose`:

```yml
bitcoinx:
  image: sunfjun/bitcoinx
  command:
    -printtoconsole
    -regtest=1
```


In the background, `bitcoinx-cli` read the information automatically from `/home/bitcoinx/.bitcoinx/regtest/.cookie`. In production, the path would not contain the regtest part.

Done!

## Images

The `sunfjun/bitcoinx` image comes in multiple flavors:

### `sunfjun/bitcoinx:latest`

Points to the latest release available of BitcoinX. Occasionally pre-release versions will be included.

### `sunfjun/bitcoinx:<version>`

Based on a slim Debian image, targets a specific version branch or release of BitcoinX.

### `sunfjun/bitcoinx:<version>-stretch-slim`

Based on a slim Debian image, targets a specific version branch or release of BitcoinX.

## Supported Docker versions

This image is officially supported on Docker version 17.09.0-ce, with support for older versions provided on a best-effort basis.
