#!/bin/bash
set -e -u

# Symlinks all the files in this dotfiles repository to their proper
# locations in $HOME.

for f in $(dirname $0)/*; do
  
  # don't link this script or the readme
  if [ $(basename $f) = $(basename $0) ]; then continue; fi
  if [ $(basename $f) = 'README.md' ]; then continue; fi

  linksrc="$(readlink -f $f)"
  linkdst="$HOME/.$(basename $f)"
  
  if [ -h $linkdst ]; then
    # if the destination already exists as a symlink, replace it without asking
    ln -sf "$linksrc" "$linkdst"
  else
    # otherwise ask what to do if the file is already there, or just link it if not
    ln -si "$linksrc" "$linkdst"
  fi

done
