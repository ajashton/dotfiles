export EDITOR=hx
export GREP_COLOR="1;30;42"
export PAGER=most
export PGUSER=postgres
export TMPDIR=/tmp
export TMP=/tmp
export ZDOTDIR="$HOME/.config/zsh"

export PATH="$HOME/.local/bin:$PATH"

# Go
if [ -s "$HOME/.go" ]; then
  export GOPATH="$HOME/.go"
  export PATH=$PATH:/usr/local/go/bin:$HOME/.go/bin
fi

# Node.js
if [ -s "$HOME/.nvm/nvm.sh" ]; then
  export NVM_DIR="$HOME/.nvm"
  \. "$NVM_DIR/nvm.sh"
  \. "$NVM_DIR/bash_completion"
fi

# Rust
if [ -d "$HOME/.cargo/bin" ]; then
  export PATH="$HOME/.cargo/bin:$PATH"
fi
