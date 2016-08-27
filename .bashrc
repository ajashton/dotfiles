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

if [[ -d "$HOME/.gem/ruby/2.3.0/bin" ]]; then
    PATH="$HOME/.gem/ruby/2.3.0/bin:$PATH"
fi

if [[ -e "$HOME/.python/bin/activate" ]]; then
    source "$HOME/.python/bin/activate"
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.local/bin" ]; then
    PATH="$HOME/.local/bin:$PATH"
fi

if [[ -e "$HOME/.nvm/nvm.sh" ]]; then
    source "$HOME/.nvm/nvm.sh"
fi

if [[ -e "$(npm root -g)/mbxcli/mapbox.sh" && -n "$(which node)" ]]; then
    source "$(npm root -g)/mbxcli/mapbox.sh"
    function mbxc() {
        mbx auth $* --account china
    }
fi


# ---- History --------------------------------------------------------

shopt -s histappend
export PROMPT_COMMAND="history -a; history -n;"
export HISTCONTROL=erasedups
export HISTFILE="$HOME/.bash_history"
export HISTSIZE=50000
export HISTIGNORE='&:ls:cd ~:cd ..:[bf]g:exit:h:history'

# ---- Remember last CWD ----------------------------------------------
PROMPT_COMMAND+=" pwd > $HOME/.cache/lwd;"
if [[ -e "$HOME/.cache/lwd" ]]; then
    cd "$(< ${HOME}/.cache/lwd)"
fi

# ---- Window Title ---------------------------------------------------

# If we're inside a tmux or screen session, set title to the current 
# working directory abbreviated similarly to Vim tabs, eg:
# '/home/aj/foo/bar/baz' => '~/f/b/baz'
function pwd_abbr () {
    echo -ne "\ek$(pwd | sed s#$HOME#~# | sed 's#\([^/]\)[^/]*/#\1/#g')\e\\"
}
if (grep -qe '\(screen\|tmux\)' <<< "$TERM"); then
    PROMPT_COMMAND+=" pwd_abbr;"
fi

# ---- Shell Prompt ---------------------------------------------------

# Functions to tell me whether I am in a git or svn working copy, + which branch
parse_git_branch() {
  git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'
}
parse_hg_branch() {
  hg summary 2> /dev/null | grep ^branch | sed -e 's/.*: \(.*\)/\1/'
}

# The prompt itself
if [ $TERM = 'dumb' ] ; then
    # No color, no unicode (eg, Vim shell)
    export PS1="\$(date +%H:%M) \[\033[G\]\w \$(parse_git_branch)\$(parse_hg_branch)\$(parse_svn_branch) $ "
else
    # Default: Full-color, Unicode
    export PS1="\[\033[31m\]\$(date +%H:%M) \[\033[01;34m\]\w \[\033[32m\]\$(parse_git_branch)\$(parse_hg_branch)\[\033[00m\] $ "
fi

# == ALIASES ==========================================================

# ---- Alternatives ---------------------------------------------------

if [[ -x /usr/bin/colordiff ]]; then alias diff='colordiff'; fi
if [[ -x /usr/bin/most ]]; then alias less='most'; fi
if [[ -x /usr/bin/pacman-color ]]; then alias pacman='pacman-color'; fi
alias todo='todo.sh'

# ---- Preferred Default Options --------------------------------------

alias df='df -h'
alias gist='gist -p'
alias grep='grep --color=auto'
alias mkdir='mkdir -p'
alias mv='mv -vi'
alias rm='rm -v'
alias vlc='vlc --extraintf http'

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
follow() { [ -d "$1" ] && cd "$1" || cd "$(dirname "$1")"; }
cpf() { cp "$@" && follow "$_"; }
mvf() { mv "$@" && follow "$_"; }

# Make one or more directories, and cd to the last one in the list
mkcd() { mkdir -p "$@" && cd "$_"; }

# Easily hide/unhide files (via dot-prefix)
hide() {
    for f in "$@"; do
        mv -i "$f" $(dirname "$f")/".$(basename "$f")"
    done
}
unhide() {
    for f in "$@"; do
        mv -i "$f" $(dirname "$f")/"$(basename "$f" | sed 's/^\.//')"
    done
}

function xt() {
  # xt = eXTract, a wrapper to extract many different archive formats
  if [ -f $1 ] ; then
    case $1 in
      *.tar.bz2)   tar xvjf "$1"   ;;
      *.tar.gz)    tar xvzf "$1"   ;;
      *.tar.xz)    tar xzJf "$1"   ;;
      *.bz2)       bunzip2 "$1"    ;;
      *.rar)       unrar x "$1"    ;;
      *.gz)        gunzip "$1"     ;;
      *.tar)       tar xvf "$1"    ;;
      *.tbz2)      tar xvjf "$1"   ;;
      *.tgz)       tar xvzf "$1"   ;;
      *.zip)       unzip "$1"      ;;
      *.Z)         uncompress "$1" ;;
      *.7z)        7z x "$1"       ;;
      *)           echo "'$1' cannot be extracted via >extract<" ;;
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
