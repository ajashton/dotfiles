# If not running interactively, don't do anything
test -z "$PS1" && return

# Global settings
test -r $HOME/.bash/bashrc.global && . $HOME/.bash/bashrc.global

# Goto script
test -r $HOME/.bash/bashrc.goto && . $HOME/.bash/bashrc.goto

# Apparix helpers, if apparix is available
test -x `which apparix` && test -r $HOME/.bash/bashrc.apparix && \
    . $HOME/.bash/bashrc.apparix

# Local-specific options
test -r $HOME/.bashrc.local && . $HOME/.bashrc.local
