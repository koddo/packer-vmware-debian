#!/usr/bin/env bash

set -eux

# Sample custom configuration script - add your own commands here
# to add some additional commands for your environment
#
# For example:
# yum install -y curl wget git tmux firefox xvfb



SSH_USER=${SSH_USER:-vagrant}
SSH_USER_HOME=${SSH_USER_HOME:-/home/${SSH_USER}}


## add my keys
mkdir -pm 700 $SSH_USER_HOME/.ssh
curl https://github.com/koddo.keys > $SSH_USER_HOME/.ssh/authorized_keys
chmod 600 $SSH_USER_HOME/.ssh/authorized_keys
chown -R $SSH_USER:$SSH_USER $SSH_USER_HOME/.ssh


## disable passwords
## sshd is going to use this after reboot when the vm is ready
sed -i 's/\#PasswordAuthentication yes/PasswordAuthentication no/' /etc/ssh/sshd_config

