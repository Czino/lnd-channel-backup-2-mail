#!/bin/bash

EMAIL="your@email.com"
PATHTOLND="/home/lightning/.lnd/"
PATHTOTMP="/home/lightning/tmp"

while true; do
    inotifywait "$PATHTOLND/data/chain/bitcoin/mainnet/channel.backup"
    cp "$PATHTOLND/data/chain/bitcoin/mainnet/channel.backup" "$PATHTOTMP/channel.backup"

    echo "Your channels have been updated, here's your backup" | mail -s "LND Channel Backup" "$EMAIL" -A channel.backup
done

while true; do
    inotifywait "$PATHTOLND/data/chain/bitcoin/testnet/channel.backup"
    cp "$PATHTOLND/data/chain/bitcoin/testnet/channel.backup" "$PATHTOTMP/channel-test.backup"

    echo "Your channels have been updated, here's your backup" | mail -s "LND Channel Backup (Testnet)" "$EMAIL" -A channel-test.backup
done
