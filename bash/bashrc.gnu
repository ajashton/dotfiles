# For things that only make sense on GNU/Linux systems


# == ALIASES ==========================================================

# ---- Alternatives ---------------------------------------------------

alias open='xdg-open'
alias xclip='xclip -selection c'
test -x /usr/bin/pacman-color && alias pacman='pacman-color' # Arch

# power management
alias shutdown='sudo shutdown -h now'
alias reboot='sudo shutdown -r now'
alias suspend='sudo pm-suspend'
alias hibernate='sudo pm-hibernate'

# ---- Shortcuts  -----------------------------------------------------

alias ffeh='feh -FZ'

alias mp3name='eyeD3 --rename="%n. %t"'

# == FUNCTIONS ========================================================

nwd() {
  $*
  notify-send "$1 is done!"
}

py2plz() { sudo sh -c "cd /usr/bin && ln -fs python2 python"; }
py3plz() { sudo sh -c "cd /usr/bin && ln -fs python3 python"; }

