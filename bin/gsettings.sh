# gnome settings

gs='gsettings set'

# interpret 1/2/3-finger taps on the touchpad as left/right/middle mouse clicks:
$gs org.gnome.desktop.peripherals.touchpad          click-method            'fingers'
$gs org.gnome.settings-daemon.peripherals.touchpad  horiz-scroll-enabled    true
$gs org.gnome.settings-daemon.peripherals.touchpad  natural-scroll          true
$gs org.gnome.settings-daemon.peripherals.touchpad  scroll-method           two-finger-scrolling
$gs org.gnome.settings-daemon.peripherals.touchpad  tap-to-click            false
# prevents xmodmap from being overridden:
$gs org.gnome.settings-daemon.plugins.keyboard      active                  false
# prevents Mod4+P from switching displays:
$gs org.gnome.settings-daemon.plugins.xrandr        active                  false
$gs org.gnome.desktop.calendar                      show-weekdate           true
$gs org.gnome.desktop.input-sources                 xkb-options             "['caps:escape','compose:ralt']"
$gs org.gnome.desktop.media-handling                automount-open          false
$gs org.gnome.desktop.screensaver                   lock-enabled            false
$gs org.gnome.desktop.wm.preferences                mouse-button-modifier   '<Mod4>'
$gs org.gnome.nautilus.preferences                  enable-delete           true
$gs org.gnome.shell.overrides                       button-layout           'close,maximize:'
for i in {1..9}; do $gs org.gnome.shell.keybindings switch-to-application-$i "[]"; done
