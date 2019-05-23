#!/bin/bash

bridge=mybridge

sudo ip netns add ns1
sudo ip netns add ns2

sudo ip link add veth-ns1 type veth peer name ns1eth0
sudo ip link add veth-ns2 type veth peer name ns2eth0

sudo ip link set ns1eth0 netns ns1
sudo ip link set ns2eth0 netns ns2

sudo ip netns exec ns1 ip link set dev lo up
sudo ip netns exec ns1 ip addr add 10.200.1.2/24 dev ns1eth0
sudo ip netns exec ns1 ip link set dev ns1eth0 up


sudo ip netns exec ns2 ip link set dev lo up
sudo ip netns exec ns2 ip addr add 10.200.1.3/24 dev ns2eth0
sudo ip netns exec ns2 ip link set dev ns2eth0 up

sudo ip netns exec ns1 ip route add default via 10.200.1.1
sudo ip netns exec ns2 ip route add default via 10.200.1.1

sudo ip link set dev veth-ns1 up
sudo ip link set dev veth-ns2 up

sudo brctl addif $bridge veth-ns1
sudo brctl addif $bridge veth-ns2
