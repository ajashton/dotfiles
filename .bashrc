# If not running interactively, don't do anything
if [[ -z "${PS1:-}" ]]; then return; fi

shopt -s checkwinsize

# let autocomplete work with sudo
complete -cf sudo

# == ENVIRONMENT ======================================================

if [[ -x /usr/bin/nvim ]]; then
    export EDITOR=nvim
elif [[ -x /usr/bin/vim ]]; then
    export EDITOR=vim
fi
export GREP_COLOR="1;33"
export TMP=/tmp
export TMPDIR=/tmp
export PGUSER=postgres
if [[ -x /usr/bin/most ]]; then
    export PAGER=most
fi

eval "$(keychain --eval --quiet --quick --confhost --noask --nogui \
    --timeout 43200 --agents ssh,gpg ~/.ssh/id_rsa 251886EF)"

if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

if [[ -e "$HOME/.python/bin/activate" ]]; then
    source "$HOME/.python/bin/activate"
fi

# set PATH so it includes user's private bin if it exists
if [[ -d "$HOME/.local/bin" ]]; then
    PATH="$HOME/.local/bin:$PATH"
fi

if [[ -s "$HOME/.nvm/nvm.sh" ]]; then
    export NVM_DIR="$HOME/.nvm"
    \. "$NVM_DIR/nvm.sh"  # This loads nvm
    \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
    nvm use v6
fi

if [[ -e "$(npm root -g)/mbxcli/mapbox.sh" && -n "$(which node)" ]]; then
    source "$(npm root -g)/mbxcli/mapbox.sh"
    function mbxc() {
        mbx auth "$@" --account china
    }
fi

if [[ -f "$HOME/.travis/travis.sh" ]]; then
    source "$HOME/.travis/travis.sh"
fi


# ---- History --------------------------------------------------------

HISTCONTROL=erasedups:erasedups
HISTFILE="$HOME/.bash_history"
HISTSIZE=-1
HISTFILESIZE=-1
HISTIGNORE='&:ls:cd ~:cd ..:[bf]g:exit:h:history'
shopt -s histappend

# ---- Remember last CWD ----------------------------------------------
PROMPT_COMMAND+=" pwd > $HOME/.cache/lwd;"
if [[ -e "$HOME/.cache/lwd" ]]; then
    cd "$(< "${HOME}/.cache/lwd")"
fi

# ---- Window Title ---------------------------------------------------

# Set window/tab title to the current working directory, abbreviated
# similarly to Vim tabs, eg: '/home/aj/foo/bar/baz' => '~/f/b/baz'
# Also include a relevant emoji if mbx-authed.
function set_window_title () {
    local mbxauth=''
    local dirname
    if [[ $((MAPBOX_CLI_AUTH_TIME/1000)) -gt $(date +%s) ]]; then
        case "$MAPBOX_AWS_ACCOUNT" in
            ch*) mbxauth=' 🈶';;
            pr*) mbxauth=' 🌐';;
            *) ;;
        esac
    fi
    dirname="$(pwd | sed -e "s#$HOME#~#" -e 's#\([^/]\)[^/]*/#\1/#g')"
    echo -en "\033]2;${dirname}${mbxauth}\007"
}
PROMPT_COMMAND+=" set_window_title;"

# ---- Shell Prompt ---------------------------------------------------

# Functions to tell me whether I am in a git or svn working copy, + which branch
parse_git_branch() {
  git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'
}

if [[ -n "$SSH_CONNECTION" ]]; then
    # Show user/host only when SSH'd in
    sshinfo="\[\033[01;33m\]\u@\h:"
fi

# The prompt itself
if [[ $TERM = 'dumb' ]]; then
    # No color, no unicode (eg, Vim shell)
    export PS1="\$(date +%H:%M) \[\033[G\]\w \$(parse_git_branch) $ "
else
    # Default: Full-color, Unicode
    export PS1="\[\033[31m\]\$(date +%H:%M) ${sshinfo:-}\[\033[01;34m\]\w \[\033[32m\]\$(parse_git_branch)\[\033[00m\] $ "
fi

# == ALIASES ==========================================================

# ---- Alternatives ---------------------------------------------------

if [[ -x /usr/bin/colordiff ]]; then alias diff='colordiff'; fi
if [[ -x /usr/bin/most ]]; then alias less='most'; fi
if [[ -x /usr/bin/pacman-color ]]; then alias pacman='pacman-color'; fi
alias todo='todo.sh'

# ---- Preferred Default Options --------------------------------------

alias df='df --human-readable --print-type'
alias gist='gist -p'
alias grep='grep --color=auto'
alias mkdir='mkdir -p'
alias mv='mv -vi'

# ---- Shortcuts  -----------------------------------------------------

# ls
alias ls='ls -F --color=auto'            # a couple good defaults
alias l='ls -F --color=auto'             # 50% less typing!
alias ll='ls -Fhl --color=auto'          # long list
alias la='ls -AFh --color=auto'          # list all
alias lla='ls -AFl --color=auto'         # long list all
alias lr='ls -FR --color=auto'           # list recursive
alias llr='ls -FlR --color=auto'         # long list recursive
alias lx='ls -lXB --color=auto'          # sort by extension
alias lm='ls -Fl --color=always | most'  # pipe to most, with color

# cd
alias cd..='cd ..'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias ......='cd ../../../../..'

if [[ -x /usr/bin/xdg-open ]]; then alias open='xdg-open'; fi
if [[ -x /usr/bin/xclip ]]; then
    alias pbcopy='xclip -in -selection clipboard'
    alias pbpaste='xclip -out -selection clipboard'
fi

# power management
alias shutdown='sudo shutdown -h now'
alias reboot='sudo shutdown -r now'
alias suspend='sudo pm-suspend'
alias hibernate='sudo pm-hibernate'

# file management
alias ffeh='feh -FZ'
alias mp3name='eyeD3 --rename="%n. %t"'

function bak() {
    for file in "$@"; do
        mv "$file"{,.bak}
    done
}

# Follow copied and moved files to destination directory (courtesy jwr)
follow() {
    if [[ -d "$1" ]]; then
        cd "$1"
    else
        cd "$(dirname "$1")"
    fi
}
cpf() { cp "$@" && follow "$_"; }
mvf() { mv "$@" && follow "$_"; }

# Make one or more directories, and cd to the last one in the list
mkcd() { mkdir -p "$@" && cd "$_"; }

# Easily hide/unhide files (via dot-prefix)
hide() {
    for f in "$@"; do
        mv -i "$f" "$(dirname "$f")/.$(basename "$f")"
    done
}
unhide() {
    for f in "$@"; do
        mv -i "$f" "$(dirname "$f")/$(basename "$f" | sed 's/^\.//')"
    done
}

function xt() {
  # xt = eXTract, a wrapper to extract many different archive formats
  if [ -f "$1" ] ; then
    case "$1" in
      *.tar.bz2)   tar xvjf "$1";;
      *.tar.gz)    tar xvzf "$1";;
      *.tar.lz4)   tar -I lz4 -xf "$1";;
      *.tar.xz)    tar xzJf "$1";;
      *.bz2)       bunzip2 "$1";;
      *.rar)       unrar x "$1";;
      *.gz)        gunzip "$1";;
      *.tar)       tar xvf "$1";;
      *.tbz2)      tar xvjf "$1";;
      *.tgz)       tar xvzf "$1";;
      *.zip)       unzip "$1";;
      *.Z)         uncompress "$1";;
      *.7z)        7z x "$1";;
      *)           echo "'$1' cannot be extracted by xt";;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}

# run command, notify when done
nwd() {
  "$@"
  notify-send "$1 is done!"
}

function osmfilter() {
    # transparently handles pbf→o5m→pbf conversion
    if [[ $1 == *.osm.pbf ]]; then
        local original="$1"
        shift
        local in_o5m="${original//.osm.pbf/.o5m}"
        local out_o5m="${in_o5m//.o5m/_filtered.o5m}"
        local out_pbf="${out_o5m//.o5m/.osm.pbf}"
        osmconvert "$original" --out-o5m > "$in_o5m"
        $(which osmfilter) "$in_o5m" "$@" --out-o5m > "$out_o5m"
        osmconvert "$out_o5m" --out-pbf > "$out_pbf"
    else
        $(which osmfilter) "$@"
    fi
}

