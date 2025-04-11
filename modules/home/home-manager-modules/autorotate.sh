#!/usr/bin/env bash
GREP_STRING="orientation changed:"
ORIENTATIONS=("normal" "left-up" "right-up" "bottom-up")

monitor-sensor | while read -r line; do
  if [[ "$line" == *"$GREP_STRING"* ]]; then
    for key in "${ORIENTATIONS[@]}"; do
      if [[ "$line" == *"$key"* ]]; then
        if [[ "$key" == *"bottom-up"* ]]; then
          kscreen-doctor output.1.rotation.inverted &
          break
        else
          kscreen-doctor output.1.rotation."${key/-up}" &
          break
        fi
      fi
    done
  fi
done
# This script listens for orientation changes from the monitor-sensor command
# and uses kscreen-doctor to set the screen orientation accordingly.