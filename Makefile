DEFAULT = fontconfig git postgresql ranger shell ssh starship tmux vim
CUSTOM = bash zsh

# These directories must exist before stow runs otherwise the symlinks
# will not be set up correctly.
DIRS = \
	${HOME}/.history \
	${HOME}/.local/share/applications \
	${HOME}/.local/share/icons

.PHONY: $(DEFAULT) $(CUSTOM)

all: $(DEFAULT) $(CUSTOM)

$(DIRS):
	mkdir -p $@

$(DEFAULT): $(DIRS)
	stow $@

bash: shell starship
	stow $@

zsh: shell starship
	stow $@
