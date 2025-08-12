#!/usr/bin/env bash

cmd="$1"
echo $cmd
# if the command is running
if ! pgrep -fx "$cmd" > /dev/null
then
    $cmd &
fi