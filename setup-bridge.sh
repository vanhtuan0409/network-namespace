#!/bin/bash

bridge=mybridge
sudo brctl addbr $bridge
sudo brctl stp $bridge off
sudo ip link set dev $bridge up
sudo ip addr add 10.200.1.1/24 dev $bridge
