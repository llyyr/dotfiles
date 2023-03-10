#!/bin/bash

export LIBVA_DRIVER_NAME=iHD

pid=`pgrep wf-recorder`
status=$?

if [ $status != 0 ]
then 
    # sudo ffmpeg -framerate 60 -f kmsgrab -i - -device /dev/dri/card0 -vf hwmap=derive_device=vaapi,crop="$(swaymsg -t get_tree | jq -r '.. | select(.pid? and .visible?) | .rect | "\(.x),\(.y) \(.width)x\(.height)"' | slurp -f %w:%h:%x:%y,scale_vaapi=w=%w:h=%h)":format=nv12 -c:v h264_vaapi -f pulse -i alsa_output.pci-0000_00_1f.3.analog-stereo.monitor $(xdg-user-dir VIDEOS)/$(date +'recording_%Y-%m-%d-%H%M%S.mp4');
    wf-recorder -g "$(swaymsg -t get_tree | jq -r '.. | select(.pid? and .visible?) | .rect | "\(.x),\(.y) \(.width)x\(.height)"' | slurp)" -c h264_vaapi -C libfdk_aac -d "/dev/dri/renderD129" -aalsa_output.pci-0000_00_1f.3.analog-stereo.monitor -f $(xdg-user-dir VIDEOS)/$(date +'recording_%Y-%m-%d-%H%M%S.mp4');
    # wf-recorder -g "$(swaymsg -t get_tree | jq -r '.. | select(.pid? and .visible?) | .rect | "\(.x),\(.y) \(.width)x\(.height)"' | slurp)" -c libx264 -C libfdk_aac -aalsa_output.pci-0000_00_1f.3.analog-stereo.monitor -f $(xdg-user-dir VIDEOS)/$(date +'recording_%Y-%m-%d-%H%M%S.mp4');
else 
    pkill --signal SIGINT wf-recorder
fi;
pkill -RTMIN+11 -x i3status-rs
