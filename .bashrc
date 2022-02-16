# vim: set ts=4 sw=4 sts=4 :

# If not running interactively, don't do anything
if [[ -z "${PS1:-}" ]]; then return; fi

shopt -s checkwinsize

# let autocomplete work with sudo
complete -cf sudo

# == ENVIRONMENT ======================================================

if (command -v kak &> /dev/null); then
    export EDITOR=kak
elif (command -v nvim &> /dev/null); then
    export EDITOR=nvim
elif (command -v vim &> /dev/null); then
    export EDITOR=vim
fi
alias e=$EDITOR

# Highlight grep matches in bold (1) with black fg (30) and green bg (42):
export GREP_COLOR="1;30;42"
export TMP=/tmp
export TMPDIR=/tmp
export PGUSER=postgres
if [[ -x /usr/bin/most ]]; then
    export PAGER=most
fi

# nvm: node.js version manager
if [[ -s "$HOME/.nvm/nvm.sh" ]]; then
    export NVM_DIR="$HOME/.nvm"
    \. "$NVM_DIR/nvm.sh"
    \. "$NVM_DIR/bash_completion"
fi

if (command -v rg &> /dev/null); then
    # By default fzf uses `find` - if ripgrep is installed then using
    # that is a better option.
    export FZF_DEFAULT_COMMAND='rg --files --hidden -g "!.git/*"'
fi

export PROMPT_COMMAND=""  # Clear default; further additions below

if ! shopt -oq posix; then
    if [ -f /etc/bash_completion ]; then
        . /etc/bash_completion
    elif [ -f /etc/profile.d/bash_completion.sh ]; then
        . /etc/profile.d/bash_completion.sh
    fi
fi

if [[ -n "$(command -v npm 2> /dev/null)" ]] \
    && [[ -e "$(npm root -g)/@mapbox/mbxcli/bin/mapbox.sh" ]]
    export AWS_DEFAULT_REGION=us-east-1
then
  source "$(npm root -g)/@mapbox/mbxcli/bin/mapbox.sh"
  alias mbxe="mbx env -a default"
fi


# ---- History --------------------------------------------------------

HISTFILE="$HOME/.bash_history"
HISTCONTROL=ignoredups:erasedups
HISTSIZE=50000
HISTFILESIZE=500000
HISTIGNORE='&:ls:cd ~:cd ..:[bf]g:exit:h:history'
shopt -s histappend
PROMPT_COMMAND="history -a; $PROMPT_COMMAND"

# ---- Window Title ---------------------------------------------------

# Set window/tab title to the current working directory, abbreviated
# similarly to Vim tabs, eg: '/home/aj/foo/bar/baz' => '~/f/b/baz'
# Also include a relevant emoji if mbx-authed.
function set_window_title () {
    local dirname
    dirname="$(pwd | sed -e "s|$HOME|~|" -e 's|\([^/]\)[^/]*/|\1/|g')"
    echo -en "\033]2;${dirname}\007"
}
PROMPT_COMMAND+=" set_window_title;"

# ---- Shell Prompt ---------------------------------------------------

# Functions to tell me whether I am in a git repo + which branch
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
if (command -v trash &> /dev/null); then alias rm=trash; fi

# ---- Preferred Default Options --------------------------------------

alias df='df --human-readable --print-type'
alias gist='gist -p'
alias grep='grep --color=auto'
alias mkdir='mkdir -p'
alias mv='mv -vi'

# ---- Shortcuts  -----------------------------------------------------

# aws
alias s3cp='aws s3 cp'
alias s3ls='aws s3 ls --human-readable'
alias s3mv='aws s3 mv'
alias s3rm='aws s3 rm'
alias aparallel='parallel --env AWS_SECRET_ACCESS_KEY --env AWS_SESSION_TOKEN --env AWS_ACCESS_KEY_ID'

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

function xt() {
  # eXTracts many different archive/compression formats
  if [ -f "$1" ] ; then
    case "$1" in
      # tar can auto-detect the right compression option
      # http://www.gnu.org/software/tar/manual/tar.html#auto_002dcompress
      *.tar.*|*.taz|*.taZ|*.tgz|*.tz2|*.tbz|*.tlz|*.tzst) tar xvaf "$1";;
      *.7z)     7z x "$1";;
      *.bz2)    bunzip2 "$1";;
      *.gz)     gunzip "$1";;
      *.rar)    unrar xv "$1";;
      *.tar)    tar xvf "$1";;
      *.xz)     unxz "$1";;
      *.Z)      uncompress "$1";;
      *.zip)    unzip "$1" -x '__MACOSX/*' '*.DS_Store';;
      *.zst)    unzst "$1";;
      *) echo "'$1' cannot be extracted by xt";;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}

function sum() {
    python -c "import sys; print(sum(map(int, sys.stdin)))"
}

# tcalc: a time calculator using PostgreSQL
# example: `tcalc 10:41:02 + 16h43m` → 27:24:02
function tcalc() {
    local query="select interval '"
    query+="$(sed $'s,\(\\s*[-+]\\s*\),\' \\1\ interval \',g' <<< "$@")"
    query+="';"
    psql -AqtX -c "$query"
}

# Docker

function docker_latest() {
    docker ps --format "{{.ID}}" | head -n1
}

function dock() {
    # Connect to a bash session in the latest running docker container
    docker exec -it "$(docker_latest)" bash
}

function dkill() {
    docker kill "$(docker_latest)"
}

function docker_ip() {
    docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' "$(docker_latest)"
}

function s3_undelete() {
  s3_bucket="$1"
  if [[ -z "${s3_bucket:-}" ]]; then
    echo "Missing S3 bucket argument"
    return
  fi

  s3_key="$2"
  if [[ -z "${s3_key:-}" ]]; then
    echo "Missing S3 key argument"
    return
  fi

  if (aws s3 ls "s3://${s3_bucket}/${s3_key}" &> /dev/null); then
    echo "s3://${s3_bucket}/${s3_key} is already undeleted"
    return
  fi

  version_id="$(aws s3api list-object-versions \
      --bucket "$s3_bucket" --prefix "$s3_key" \
      --query 'DeleteMarkers[?IsLatest==`true`]' \
    | jq -r '.[] | select(.IsLatest==true) | .VersionId')"

  aws s3api delete-object \
    --bucket "$s3_bucket" --key "$s3_key" \
    --version-id "$version_id"

  aws s3 ls "s3://${s3_bucket}/${s3_key}" \
    || echo "Failed to restore $s3_key"
}

# Docker-compatible Podman

if (command -v podman &> /dev/null) && ! (command -v docker &> /dev/null); then
    function docker() {
        command="$1"
        shift
        if [[ "$command" == "run" ]]; then
            podman run --security-opt label=disable --rm "$@"
        elif [[ "$command" == "build" ]]; then
            podman build --format=docker "$@"
        else
            podman $command "$@"
        fi
    }
fi

