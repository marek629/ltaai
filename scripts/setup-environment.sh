#!/bin/bash

set -eux;

echo "Setting up ${target} environment...";

case "$target" in
    catch2)
        apt-get install -y catch2 cmake g++;
        ;;
    lua)
        apt-get install -y --no-install-recommends lua5.5 luarocks;
        ;;
    yarn)
        apt-get install -y --no-install-recommends nodejs node-corepack \
        && corepack enable;
        ;;
    pytest)
        apt-get install -y --no-install-recommends \
            python3 python3-pip python3-pytest;
        ;;
    *)
        echo "ERROR: Unknown target: '$target'";
        exit 1;
        ;;
esac;

rm -rf /var/lib/apt/lists/*
