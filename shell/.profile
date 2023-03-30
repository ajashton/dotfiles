#!/bin/sh

export EDITOR=hx
export GREP_COLOR="1;30;42"
export HIGHLIGHT_STYLE=bluegreen
export PAGER=most
export PGUSER=postgres
export SQLITE_HISTORY="$HOME/.history/sqlite"
export TMPDIR=/tmp
export TMP=/tmp
export ZDOTDIR="$HOME/.config/zsh"
export LC_CTYPE=en_US.UTF-8
export LC_ALL=en_US.UTF-8

export PATH="$HOME/.local/bin:$PATH"

if [ "$XDG_SESSION_DESKTOP" = "KDE" ]; then
  export SSH_ASKPASS=/usr/bin/ksshaskpass
fi

if [ -z "$SSH_AGENT_PID" ]; then
    eval "$(ssh-agent -s)"
fi

# Go
if [ -d "$HOME/.go" ]; then
  export GOPATH="$HOME/.go"
  export PATH=$PATH:/usr/local/go/bin:$HOME/.go/bin
fi

# Node.js via n
if [ -d "$HOME/.nodejs" ]; then
  export N_PREFIX="$HOME/.nodejs"
  export PATH="$N_PREFIX/bin:$PATH"
fi

# Rust
if [ -d "$HOME/.cargo/bin" ]; then
  export PATH="$HOME/.cargo/bin:$PATH"
fi
