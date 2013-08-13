# If not running interactively, don't do anything
test -z "$PS1" && return

# Global settings
test -r $HOME/.bash/bashrc.global && . $HOME/.bash/bashrc.global

# GNU/Linux-specific settings
if [ $(uname) = 'Linux' ]; then . $HOME/.bash/bashrc.gnu; fi

# Goto script
test -r $HOME/.bash/bashrc.goto && . $HOME/.bash/bashrc.goto

# Apparix helpers
test -r $HOME/.bash/bashrc.apparix && . $HOME/.bash/bashrc.apparix

# Local-specific options
test -r $HOME/.bashrc.local && . $HOME/.bashrc.local