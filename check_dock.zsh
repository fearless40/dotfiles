#!/bin/zsh 
## Check for the number of graphics cards and set the settings

local cardCount=$(ls /dev/dri | grep card | wc -l)
local nvidia_pc=$(lspci | grep VGA | grep NVIDIA | awk '{print $1}')
if [[ -n "$nvidia_pc" ]] then 
   local nvidia_card=$(ls -la /dev/dri/by-path/ | grep $nvidia_pc | grep card | awk '{sub("../","",$11); print $11}')
   echo "env = AQ_DRM_DEVICES,/dev/dri/$nvidia_card" > ~/.config/hypr/env.conf
   ln -sf ~/.config/ghostty/config_docked ~/.config/ghostty/config
else
   local intel_pc=$(lspci | grep VGA | grep Intel | awk '{print $1}') 
   local intel_card=$(ls -la /dev/dri/by-path/ | grep $intel_pc | grep card | awk '{sub("../","",$11); print $11}')
   echo "env = AQ_DRM_DEVICES,/dev/dri/$intel_card" > ~/.config/hypr/env.conf
   ln -sf ~/.config/ghostty/config_undocked ~/.config/ghostty/config
fi
