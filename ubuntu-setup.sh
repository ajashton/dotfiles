#!/bin/bash

# add additional package sources
sudo apt-add-repository -y ppa:mapnik/nightly-trunk
sudo apt-get update -y

# install additional packages
# - libreoffice-base is necessary for DBF support in LibreOffice Calc
# - exuberant-ctags is for Vim
sudo apt-get install \
    curl \
    exuberant-ctags \
    gcolor2 \
    gimp \
    htop \
    inkscape \
    irssi \
    libjemalloc1 \
    libmapnik \
    libmapnik-dev\
    libprotobuf-dev \
    libreoffice-base \
    mapnik-utils \
    meld \
    most \
    optipng \
    postgresql \
    postgresql-contrib \
    postgis \
    protobuf-compiler \
    python-dev \
    python-pip \
    python-lxml \
    s3cmd \
    sqlite3 \
    tmux \
    vim \
    xclip

# postgres: trust 'postgres' user locally
sudo sed -i 's/\(local *all *postgres *\)peer/\1trust/' /etc/postgresql/*/main/pg_hba.conf

# python packages
sudo pip install unidecode

# install, activate nvm & node
curl https://raw.github.com/creationix/nvm/master/install.sh | sh
. ~/.nvm/nvm.sh
nvm install 0.10

# gnome settings
gs='gsettings set'
$gs org.gnome.settings-daemon.peripherals.touchpad  horiz-scroll-enabled    true
$gs org.gnome.settings-daemon.peripherals.touchpad  natural-scroll          true
$gs org.gnome.settings-daemon.peripherals.touchpad  scroll-method           two-finger-scrolling
$gs org.gnome.settings-daemon.peripherals.touchpad  tap-to-click            false
$gs org.gnome.desktop.interface                     font-name               'Open Sans 10'
$gs org.gnome.desktop.media-handling                automount-open          false
$gs org.gnome.desktop.wm.preferences                mouse-button-modifier   '<Mod4>'
$gs org.gnome.desktop.wm.preferences                titlebar-font           'Open Sans Bold 9'

