#!/bin/bash
screen -X -S daily quit
cd daily
make clean
make
cd ~
[ "$1" = "--" ] && shift
screen -dmS daily bash -c "cd ~/daily/SH_C; python3 DailyTestEverything.py; exec sh"
