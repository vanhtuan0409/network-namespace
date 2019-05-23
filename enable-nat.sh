#!/bin/bash

sudo iptables \
  -t nat \
  -A POSTROUTING \
  -s 10.200.1.0/24 \
  -j MASQUERADE

# Change your network interface here
sudo iptables -A FORWARD -i enp0s31f6 -o mybridge -j ACCEPT
sudo iptables -A FORWARD -o enp0s31f6 -i mybridge -j ACCEPT

sudo iptables -A FORWARD -i wlp2s0 -o mybridge -j ACCEPT
sudo iptables -A FORWARD -o wlp2s0 -i mybridge -j ACCEPT
