export EDITOR=hx
export GREP_COLOR="1;30;42"
export PAGER=most
export PGUSER=postgres
export SQLITE_HISTORY="$HOME/.history/sqlite"
export TMPDIR=/tmp
export TMP=/tmp
export ZDOTDIR="$HOME/.config/zsh"

export PATH="$HOME/.local/bin:$PATH"

# Go
if [ -s "$HOME/.go" ]; then
  export GOPATH="$HOME/.go"
  export PATH=$PATH:/usr/local/go/bin:$HOME/.go/bin
fi

# Node.js via n
if [ -s "$HOME/.nodejs" ]; then
  export N_PREFIX="$HOME/.nodejs"
  export PATH="$N_PREFIX/bin:$PATH"
fi

# Rust
if [ -d "$HOME/.cargo/bin" ]; then
  export PATH="$HOME/.cargo/bin:$PATH"
fi
