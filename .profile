WAYLAND=$(ps -aux | head -n -1 | grep "/usr/bin/gnome-shell --wayland")

if [ -n "$WAYLAND" ]; then
    export GDK_BACKEND=wayland
    export CLUTTER_BACKEND=wayland
fi
