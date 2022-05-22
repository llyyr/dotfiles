#!/bin/bash 
	
pid=`pgrep wf-recorder`
status=$?

if [ $status != 0 ] 
then 
    wf-recorder -g "$(swaymsg -t get_tree | jq -r '.. | select(.pid? and .visible?) | .rect | "\(.x),\(.y) \(.width)x\(.height)"' | slurp)" -a -f $(xdg-user-dir VIDEOS)/$(date +'recording_%Y-%m-%d-%H%M%S.mp4');
else 
    pkill --signal SIGINT wf-recorder
fi;
