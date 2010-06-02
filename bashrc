# If not running interactively, don't do anything
[ -z "$PS1" ] && return

[ -r $HOME/.bash/goto ] && . $HOME/.bash/goto

# == ENVIRONMENT ===============================================================

export EDITOR=vim
export GREP_COLOR="1;33"

# ---- History -----------------------------------------------------------------

shopt -s histappend
export PROMPT_COMMAND="history -w;$PROMPT_COMMAND"
export HISTCONTROL=erasedups
export HISTFILE=$HOME/.bash/history
export HISTSIZE=50000
export HISTIGNORE='&:ls:cd ~:cd ..:[bf]g:exit:h:history'

# ---- Interface ---------------------------------------------------------------

# If I am in a git or svn working copy, tell me what branch in the prompt. ie:
# 'user@host ~/git/repo (git::branch) $'
parse_git_branch() {
  git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(git::\1)/'
}
parse_svn_branch() {
  parse_svn_url | sed -e 's#^'"$(parse_svn_repository_root)"'##g' | awk -F / '{print "(svn::"$1 "/" $2 ")"}'
}
parse_svn_url() {
  svn info 2>/dev/null | grep -e '^URL*' | sed -e 's#^URL: *\(.*\)#\1#g '
}
parse_svn_repository_root() {
  svn info 2>/dev/null | grep -e '^Repository Root:*' | sed -e 's#^Repository Root: *\(.*\)#\1\/#g '
}
export PS1="\n┌─[ \[\033[00m\]\u@\h : \[\033[01;34m\]\w \[\033[31m\]\$(parse_git_branch)\$(parse_svn_branch)\[\033[00m\] ]\n└─╼ "

shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# no need to hit tab twice
set show-all-if-ambiguous on


# == ALIASES ===================================================================

# ---- Alternatives ------------------------------------------------------------

alias diff='colordiff'
alias pacman='pacman-color'
alias vi='vim'

# ---- Preferred Default Options -----------------------------------------------

alias cp='cp -v'
alias df='df -h'
alias grep='grep --color=auto'
alias mkdir='mkdir -p'
alias mv='mv -vi'
alias rm='rm -v'
alias vlc='vlc --extraintf http'

# ---- Shortcuts  --------------------------------------------------------------

alias ls='ls -F --color=auto'            # a couple good defaults
alias l='ls -F --color=auto'             # 50% less typing!
alias ll='ls -Fhl --color=auto'          # long list
alias la='ls -AFh --color=auto'          # list all
alias lla='ls -AFl --color=auto'         # long list all
alias lr='ls -FR --color=auto'           # list recursive
alias llr='ls -FlR --color=auto'         # long list recursive
alias lx='ls -lXB --color=auto'          # sort by extension
alias lm='ls -Fl --color=always | most'  # pipe to most, with color

alias cd..='cd ..'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias ......='cd ../../../../..'

alias mp3name='eyeD3 --rename="%n. %t"'

alias otf2ttf="fontforge -script $HOME/bin/otf2ttf.sh"

# power management
alias shutdown='sudo shutdown -P'
alias reboot='sudo reboot'
alias suspend='sudo pm-suspend'
alias hibernate='sudo pm-hibernate'

# daemons
alias cups='sudo /etc/rc.d/cups start'
alias lamp='sudo /etc/rc.d/httpd start && sudo /etc/rc.d/mysqld start'
alias pgsql='sudo /etc/rc.d/postgresql start'

# ssh et al
alias rsynci='rsync -e "ssh -i $HOME/.ssh/id_rsa"'
alias scpi='scp -i ~/.ssh/id_rsa'
alias sshi='ssh -i ~/.ssh/id_rsa'
alias scpe='scp -i ~/.ssh/ec2-keypair.pem'
alias sshe='ssh -i ~/.ssh/ec2-keypair.pem'
alias rsynce='rsync --progress -h -e "ssh -i $HOME/.ssh/ec2-keypair.pem"'

alias ffeh='feh -FZ'


# == FUNCTIONS =================================================================

# Follow copied and moved files to destination directory (via jwr)

follow() { [ -d "$1" ] && cd "$1" || cd "$(dirname "$1")"; }

cpf() { cp "$@" && follow "$_"; }

mvf() { mv "$@" && follow "$_"; }

# Make one or more directories, and cd to the last one in the list
mcd() { mkdir -p "$@" && goto "$_"; }

function cnik {
  # compiles a Cascadenik file into a map.xml
  # @TODO: 
  #   - option for custom output file
  #   - option for custom output directory (-d)
  
  outfile=`basename $1 .mml`.map.xml
  cascadenik-compile.py $1 > $outfile
}

function xt() {
  # xt = eXTract, a wrapper to extract many different archive formats
  if [ -f $1 ] ; then
    case $1 in
      *.tar.bz2)   tar xvjf $1     ;;
      *.tar.gz)    tar xvzf $1     ;;
      *.bz2)       bunzip2 $1      ;;
      *.rar)       unrar x $1      ;;
      *.gz)        gunzip $1       ;;
      *.tar)       tar xvf $1      ;;
      *.tbz2)      tar xvjf $1     ;;
      *.tgz)       tar xvzf $1     ;;
      *.zip)       unzip $1        ;;
      *.Z)         uncompress $1   ;;
      *.7z)        7z x $1         ;;
      *)           echo "'$1' cannot be extracted via >extract<" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}

# ---- Apparix-related ---------------------------------------------------------

function to () {
  if test "$2"; then
    cd "$(apparix --try-current-first -favour rOl "$1" "$2" || echo .)"
  elif test "$1"; then
    if test "$1" == '-'; then
      cd -
    else
      cd "$(apparix --try-current-first -favour rOl "$1" || echo .)"
    fi
  else
    cd $HOME
  fi
}

function bm () {
  if test "$2"; then
    apparix --add-mark "$1" "$2";
  elif test "$1"; then
    apparix --add-mark "$1";
  else
    apparix --add-mark;
  fi
}

function portal () {
  if test "$1"; then
    apparix --add-portal "$1";
  else
    apparix --add-portal;
  fi
}

# function to generate list of completions from .apparixrc
function _apparix_aliases () {
  cur=$2
  dir=$3
  COMPREPLY=()
  nullglobsa=$(shopt -p nullglob)
  shopt -s nullglob
  if let $(($COMP_CWORD == 1)); then
    # now cur=<apparix mark> (completing on this) and dir='to'
    # Below will not complete on subdirectories. swap if so desired.
    # COMPREPLY=( $( cat $HOME/.apparix{rc,expand} | grep "j,.*$cur.*," | cut -f2 -d, ) )
    COMPREPLY=( $( (cat $HOME/.apparix{rc,expand} | grep "\<j," | cut -f2 -d, ; ls -1p | grep '/$' | tr -d /) | grep "\<$cur.*" ) )
  else
    # now dir=<apparix mark> and cur=<subdirectory-of-mark> (completing on this)
    dir=`apparix --try-current-first -favour rOl $dir 2>/dev/null` || return 0
    eval_compreply="COMPREPLY=( $(
      cd "$dir"
      \ls -d $cur* | while read r
      do
        [[ -d "$r" ]] &&
        [[ $r == *$cur* ]] &&
          echo \"${r// /\\ }\"
      done
    ) )"
  eval $eval_compreply
  fi
  $nullglobsa
  return 0
}
# command to register the above to expand when the 'to' command's args are
# being expanded
complete -F _apparix_aliases to

# == Local Config ==============================================================

[ -r $HOME/.bashrc.local ] && . $HOME/.bashrc.local
