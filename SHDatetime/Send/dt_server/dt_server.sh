#!/bin/bash

cd ~/Documents/Code/dttests/Code
make clean
make || exit
make COPY_CODE
cd ../dt_server
choice="$1"
shift
connectAWS.sh runScriptFile ./dt_server_cleanup.sh "$choice"
connectAWS.sh sendDir ../copy_up '~/dt' "$choice"
connectAWS.sh runScriptFile ./dt_server_run.sh "$choice" "$@"
