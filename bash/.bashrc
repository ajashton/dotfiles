# shell prompt
eval "$(starship init bash)"

HISTFILE="$HOME/.history/bash"

# autocompletion
if ! shopt -oq posix; then
  if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  elif [ -f /etc/profile.d/bash_completion.sh ]; then
    . /etc/profile.d/bash_completion.sh
  fi
fi
complete -cf sudo

# load shared config files
for f in "$HOME/.config/shell/autoload/"*.sh; do 
  . "$f"
done
