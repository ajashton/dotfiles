# gnome settings

gs='gsettings set'

$gs org.gnome.settings-daemon.peripherals.touchpad  horiz-scroll-enabled    true
$gs org.gnome.settings-daemon.peripherals.touchpad  natural-scroll          true
$gs org.gnome.settings-daemon.peripherals.touchpad  scroll-method           two-finger-scrolling
$gs org.gnome.settings-daemon.peripherals.touchpad  tap-to-click            false
$gs org.gnome.desktop.interface                     font-name               'Roboto 10'
$gs org.gnome.desktop.interface                     icon-theme              'Moka'
$gs org.gnome.desktop.media-handling                automount-open          false
$gs org.gnome.desktop.screensaver                   lock-enabled            false
$gs org.gnome.desktop.wm.preferences                mouse-button-modifier   '<Mod4>'
$gs org.gnome.desktop.wm.preferences                titlebar-font           'Roboto 10'
$gs org.gnome.nautilus.preferences                  enable-delete           true
$gs org.gnome.shell.overrides                       button-layout           'close,maximize:'
