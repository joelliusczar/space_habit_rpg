#!/bin/bash
screen -X -S dt quit
cd dt
make clean
make
cd ~
[ "$1" = "--" ] && shift
screen -dmS dt bash -c "cd ~/dt; echo hello; python3 cl_dt_all.py '$1' '$2'; exec sh"
