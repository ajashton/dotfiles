# If not running interactively, don't do anything
test -z "${PS1:-}" && return

# Global settings
test -r "$HOME/.bash/bashrc.global" && . "$HOME/.bash/bashrc.global"

# GNU/Linux-specific settings
if [ "$(uname)" = 'Linux' ]; then
    source "$HOME/.bash/bashrc.gnu"
fi

# Local-specific options
test -r "$HOME/.bashrc.local" && source "$HOME/.bashrc.local"
