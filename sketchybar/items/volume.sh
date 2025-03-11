source "$PLUGIN_DIR/volume.sh"

sketchybar -m                                             \
                                        --add item volume.increase right                     \
                                        --set volume.increase icon=$VOLUME_INCREASE               \
                                        label.drawing=off             \
                                        icon.font="$FONT:Heavy:16.0"  \
                                        icon.padding_right=10         \
                                        click_script="$VOLUME_INCREASE_SCRIPT"

sketchybar -m                                             \
                                        --add item volume.decrease right                     \
                                        --set volume.decrease icon=$VOLUME_DECREASE               \
                                        label.drawing=off             \
                                        icon.font="$FONT:Heavy:16.0"  \
                                        icon.padding_right=10         \
                                        click_script="$VOLUME_DECREASE_SCRIPT"

