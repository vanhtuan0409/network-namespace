#!/bin/bash

sudo ip netns delete ns1
sudo ip netns delete ns2
sudo ip link set dev mybridge down
sudo brctl delbr mybridge


sudo iptables \
  -t nat \
  -D POSTROUTING \
  -s 10.200.1.0/24 \
  -j MASQUERADE

# Change your network interface here
sudo iptables -D FORWARD -i enp0s31f6 -o mybridge -j ACCEPT
sudo iptables -D FORWARD -o enp0s31f6 -i mybridge -j ACCEPT
sudo iptables -D FORWARD -i wlp2s0 -o mybridge -j ACCEPT
sudo iptables -D FORWARD -o wlp2s0 -i mybridge -j ACCEPT

sudo iptables -D FORWARD -i mybridge ! -o mybridge -j ACCEPT
sudo iptables -D FORWARD -i mybridge -o mybridge -j ACCEPT
