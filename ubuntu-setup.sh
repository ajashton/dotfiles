#!/bin/bash

# add additional package sources
sudo apt-add-repository -y ppa:mapnik/nightly-trunk
sudo apt-get update -y

# install additional packages
sudo apt-get install \
    curl \
    exuberant-ctags \
    gimp \
    inkscape \
    libmapnik \
    libmapnik-dev\
    mapnik-utils \
    most \
    postgresql \
    postgis \
    protobuf-compiler libprotobuf-dev \
    python-dev \
    python-pip \
    python-lxml \
    s3cmd \
    sqlite3 \
    tmux \
    unzip \
    vim

# postgres: trust 'postgres' user locally
sudo sed -i 's/\(local *all *postgres *\)peer/\1trust/' /etc/postgresql/*/main/pg_hba.conf

# install, activate nvm & node
curl https://raw.github.com/creationix/nvm/master/install.sh | sh
. ~/.nvm/nvm.sh
nvm install 0.10

# gnome settings
gsettings set org.gnome.settings-daemon.peripherals.touchpad horiz-scroll-enabled true
gsettings set org.gnome.settings-daemon.peripherals.touchpad natural-scroll true
gsettings set org.gnome.settings-daemon.peripherals.touchpad scroll-method two-finger-scrolling
gsettings set org.gnome.settings-daemon.peripherals.touchpad tap-to-click false

