#!/bin/bash

if [[ "$1" == "bitcoinx-cli" || "$1" == "bitcoinxd" ]]; then
	CMD="$1"
	shift

    if [[ -s "/run/secrets/bchrpcuser" ]]; then
        BCX_RPC_USER="$(cat /run/secrets/bcxrpcuser)"
    fi

    if [[ -s "/run/secrets/bchrpcpassword" ]]; then
        BCX_RPC_PASSWORD="$(cat /run/secres/bcxrpcpassword)"
    fi

    if [[ ! -s "$BCX_DATA/bitcoin.conf" ]]; then
cat <<-EOF > "/home/bitcoinx/bitcoin.conf"
printtoconsole=1
rpcallowip=::/0
EOF
    else
        cp "$BCX_DATA/bitcoin.conf" /home/bitcoinx/bitcoin.conf
        chmod ug+rw /home/bitcoinx/bitcoin.conf
    fi

    echo "rpcuser=${BCX_RPC_USER:-$(cat /dev/urandom | tr -dc _A-Z-a-z-0-9 | head -c16)}" >> /home/bitcoinx/bitcoin.conf
    echo "rpcpassword=${BCX_RPC_PASSWORD:-$(cat /dev/urandom | tr -dc _A-Z-a-z-0-9 | head -c16)}" >> /home/bitcoinx/bitcoin.conf

    exec "bitcoinxd" -conf=/home/bitcoinx/bitcoin.conf $@
fi

exec "$@"
