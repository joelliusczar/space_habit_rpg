#!/bin/bash

pushd ../Code
make clean
popd
choice="$1"
echo "Server stuff"
connectAWS.sh runScriptFile ./daily_server_cleanup.sh "$choice"
connectAWS.sh sendDir ../Code '~/daily' "$choice"
connectAWS.sh runScriptFile ./daily_server_run.sh "$choice"
