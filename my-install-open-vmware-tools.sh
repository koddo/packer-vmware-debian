#!/usr/bin/env bash

set -e
set -u
set -x


if [[ $PACKER_BUILDER_TYPE =~ vmware ]]; then
    echo -e "\n\ndeb http://httpredir.debian.org/debian jessie-backports main" >> /etc/apt/sources.list
    apt-get update && apt-get -t jessie-backports install -y open-vm-tools
fi


