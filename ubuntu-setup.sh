#!/bin/bash

# install additional packages
sudo apt-get install \
    curl \
    exuberant-ctags \
    most \
    postgresql \
    tmux \
    vim

# install, activate nvm & node
curl https://raw.github.com/creationix/nvm/master/install.sh | sh
. ~/.nvm/nvm.sh
nvm install 0.10
