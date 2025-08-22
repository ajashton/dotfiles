## ALTERNATES ##

if (command -v colordiff &> /dev/null); then
  alias diff='colordiff'
fi

if (command -v xdg-open &> /dev/null); then
  alias open='xdg-open'
fi

if (command -v xclip &> /dev/null); then
  alias pbcopy='xclip -in -selection clipboard'
  alias pbpaste='xclip -out -selection clipboard'
fi

if (command -v trash &> /dev/null); then
  alias rm='trash'
fi

## DEFAULTS & SHORTCUTS ##

function e() {
  setopt sh_word_split
  if [ "$EDITOR" = "kate -b" ]; then
    kate "$@"
  else
    $EDITOR "$@"
  fi
}

alias p="$PAGER"

alias cd..='cd ..'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias ......='cd ../../../../..'

alias df='df -h -T'

alias dt='date --utc --rfc-3339=seconds'

alias grep='grep --color=auto'

alias ls='ls -F --color=auto'
alias l='ls'
alias ll='ls -lh'    # long
alias la='ls -Ah'    # all
alias lla='ls -Alh'  # long all
alias lr='ls -R'     # recursive
alias llr='ls -lR'   # long recursive
alias lx='ls -lXB'   # sort by extension
alias lt='ls -lt'    # sort by time

alias mv='mv -vi'

alias mkdir='mkdir -p'

alias tree='tree -I .git -I __pycache__'

alias serve='python3 -m http.server'