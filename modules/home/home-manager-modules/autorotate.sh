#!/usr/bin/env bash
#GREP_STRING="orientation changed:"
#ORIENTATIONS=("normal" "left-up" "right-up" "bottom-up")

KDE_OUTPUT="output.1"
WLR_OUTPUT="eDP-1"

monitor-sensor | while read -r line; do
  case "$line" in
     *normal*) ORIENTATION=right ; ORIENTATION_DEGREES=180; ORIENTATION_NR=3;;
     *bottom-up*) ORIENTATION=left ; ORIENTATION_DEGREES=270; ORIENTATION_NR=1;;
     *left-up*) ORIENTATION=normal ; ORIENTATION_DEGREES=90; ORIENTATION_NR=0;;
     *right-up*) ORIENTATION=inverted ; ORIENTATION_DEGREES=0; ORIENTATION_NR=2;;
    
    #*normal*) ORIENTATION=normal ;;
    #*bottom-up*) ORIENTATION=inverted ;;
    #*left-up*) ORIENTATION=left ;;
    #*right-up*) ORIENTATION=right ;;
    *) continue ;;
  esac

  if [[ "$XDG_CURRENT_DESKTOP" == *"KDE"* ]]; then
    kscreen-doctor ${KDE_OUTPUT}.rotation."${ORIENTATION}"
  elif [[ "$XDG_SESSION_TYPE" == "wayland" && "$XDG_CURRENT_DESKTOP" == *"Hyprland"* ]]; then
    hyprctl keyword monitor ${WLR_OUTPUT}, transform, ${ORIENTATION_NR}
    hyprctl keyword input:touchdevice:transform ${ORIENTATION_NR}
  fi
done

