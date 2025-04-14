# #!/usr/bin/env bash

# monitor-sensor | while read -r line; do
#   case "$line" in
#     *normal*) ORIENTATION=normal ;;
#     *bottom-up*) ORIENTATION=inverted ;;
#     *left-up*) ORIENTATION=left ;;
#     *right-up*) ORIENTATION=right ;;
#     *) continue ;;
#   esac

#   qdbus6 org.kde.KWin /org/kde/KWin org.kde.KWin.setScreenOrientation "$ORIENTATION"
# done



#!/usr/bin/env bash
GREP_STRING="orientation changed:"
ORIENTATIONS=("normal" "left-up" "right-up" "bottom-up")

monitor-sensor | while read -r line; do
  case "$line" in
    # *normal*) ORIENTATION=right ;;
    # *bottom-up*) ORIENTATION=left ;;
    # *left-up*) ORIENTATION=normal ;;
    # *right-up*) ORIENTATION=inverted ;;
    
    *normal*) ORIENTATION=normal ;;
    *bottom-up*) ORIENTATION=inverted ;;
    *left-up*) ORIENTATION=left ;;
    *right-up*) ORIENTATION=right ;;
    *) continue ;;
  esac

  #qdbus6 org.kde.KWin /org/kde/KWin org.kde.KWin.setScreenOrientation "$ORIENTATION"
  kscreen-doctor output.1.rotation."${ORIENTATION}" &
done

# monitor-sensor | while read -r line; do
#   if [[ "$line" == *"$GREP_STRING"* ]]; then
#     for key in "${ORIENTATIONS[@]}"; do
#       if [[ "$line" == *"$key"* ]]; then
#         if [[ "$key" == *"bottom-up"* ]]; then
#           kscreen-doctor output.1.rotation.inverted &
#           break
#         else
#           kscreen-doctor output.1.rotation."${key/-up}" &
#           break
#         fi
#       fi
#     done
#   fi
# done
# This script listens for orientation changes from the monitor-sensor command
# and uses kscreen-doctor to set the screen orientation accordingly.