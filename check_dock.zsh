#!/bin/zsh 
## Check for the number of graphics cards and set the settings

local cardCount=$(ls /dev/dri | grep card | wc -l)
local nvidia_pc=$(lspci | grep VGA | grep NVIDIA | awk '{print $1}')
local nvidia_card=$(ls -la /dev/dri/by-path/ | grep $nvidia_pc | grep card | awk '{sub("../","",$11); print $11}')
local intel_pc=$(lspci | grep VGA | grep Intel | awk '{print $11}') 
local intel_card=$(ls -la /dev/dri/by-path/ | grep $intel_pc | grep card | awk '{sub("../","",$11); print $11}')



if [[ "cardCount"  -eq 1 ]] then 
   echo "env = AQ_DRM_DEVICES,/dev/dri/$intel_card" > ~/.config/hypr/env.conf
   # ln -sf ~/.config/hypr/env_undocked.conf ~/.config/hypr/env.conf
   ln -sf ~/.config/ghostty/config_undocked ~/.config/ghostty/config
else 
   # ln -sf ~/.config/hypr/env_docked.conf ~/.config/hypr/env.conf
   echo "env = AQ_DRM_DEVICES,/dev/dri/$nvidia_card" > ~/.config/hypr/env.conf
   ln -sf ~/.config/ghostty/config_docked ~/.config/ghostty/config
fi
