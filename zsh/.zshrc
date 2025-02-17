[[ -v AJ_PROFILE_LOADED ]] || . "$HOME/.profile"

# Set up the prompt
eval "$(starship init zsh)"

# Use emacs keybindings even if our EDITOR is set to vi
bindkey -e

# History settings
setopt histignorealldups sharehistory
HISTSIZE=10000
SAVEHIST=10000
HISTFILE="$HOME/.history/zsh"

# Complete current command from history using Page Up/Down
bindkey "^[[5~" history-beginning-search-backward
bindkey "^[[6~" history-beginning-search-forward

# Use modern completion system
autoload -Uz compinit
compinit

zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _expand _complete _correct _approximate
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' menu select=2
if (which dircolors &> /dev/null); then
    eval "$(dircolors -b)"
fi
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'
zstyle ':completion:*' menu select=long
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' use-compctl false
zstyle ':completion:*' verbose true

zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'

for f in "$HOME/.config/shell/autoload/"*.sh; do
    . "$f"
done

if [[ "$TERM_PROGRAM" == "vscode" ]]; then
    . "$(code --locate-shell-integration-path zsh)"
    export EDITOR="code"
    export GIT_EDITOR="code --wait"
elif [[ "$ZED_TERM" == "true" ]]; then
    if [[ -e "/Applications/Zed.app/Contents/MacOS/cli" ]]; then
        export EDITOR="/Applications/Zed.app/Contents/MacOS/cli"
    else
        export EDITOR="zed"
    fi
    export GIT_EDITOR="$EDITOR --wait"
fi
