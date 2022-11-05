if [ -f "${XDG_CONFIG_HOME:-$HOME/.config}/user-dirs.dirs" ]; then
    source "${XDG_CONFIG_HOME:-$HOME/.config}/user-dirs.dirs"
fi

if [ -z "${NOTES_DIR:-}" ]; then
    export NOTES_DIR="${XDG_DOCUMENTS_DIR:-$HOME/Documents}/Notes"
fi

function _note_usage() {
    cat <<- EOF
note v1.0.0

Usage: note [title]

Running `note My Note` will open the file "$NOTES_DIR/My Note.md" if it exists.
If that file does not exist, it will be created and populated with a Markdown
header of "My Note". For ease of use, quoting spaces in the title is not
required; the entire argument string will be treated as the title (although:do

Running `note` without arguments will use `fzf` to open a search prompt for all
*.md files in $NOTES_DIR ordered by last modified date. Selecting a file from
this list will open it in $EDITOR.

Notes will look for a NOTES_DIR environment variable to determine the root
directory to use for note storage & search. If NOTES_DIR is not already set
when the Notes script is sourced, it will be set to 
    - "$XDG_DOCUMENTS_DIR/Notes" ("$XDG_CONFIG_HOME/user-dirs.dirs" will be
      read to set XDG_DOCUMENTS_DIR if available)
    - "$HOME/Documents/Notes"
EOF
}

function note() {
    local note_name="$*"
    local note_file

    pushd "$NOTES_DIR" &> /dev/null \
        || (echo "ERROR: could not enter '$NOTES_DIR'"; return)

    if [ -z "$note_name" ]; then
        if ! (command -v fzf &> /dev/null); then
            >&2 echo "ERROR: fzf command not found"
            return 1
        fi
        # - find all *.md files in the notes dir and print their last-modified
        #   timestamps and relative paths as a null-delimited list
        # - sort the list by the timestamps, newest first
        # - remove the timestamps with sed
        # - pass the sorted names to fzf
        # - if fzf exits 0 then assign the result to note_name, otherwise stop
        if ! note_name="$(
            find . -name '*.md' -printf '%T@ %p\0' \
            | sort -zk 1nr \
            | sed -z 's/^[^ ]* //' \
            | fzf --read0
        )"; then
            # The fzf search was cancelled or errored, so don't continue to
            # the editor.
            return 1
        fi
    fi

    try_names=(
        "${note_name}.md"
        "${note_name}"
    )
    for try_name in "${try_names[@]}"; do
        if [[ -e "$try_name" ]]; then
            note_file="$try_name"
        fi
    done

    if [ -z "${note_file:-}" ]; then
        note_file="${NOTES_DIR}/${note_name}"
        if ! [[ "$note_file" = *.md ]]; then
            note_file+=".md"
        fi

        # Create the note file and pre-populate it with a title matching the basename
        note_title="$(basename "$note_name" .md)"
        echo "$note_title" > "$note_file"
        # Add title underline
        sed -e 's|.|=|g' <<< "$note_title" >> "$note_file"
        # Add a couple blank lines
        echo -e "\n" >> "$note_file"
    fi

    "${EDITOR:-vi}" "$note_file"

    popd &> /dev/null || return 1
}

_note_complete() {
    local note_prefix="$2"
    local note_file
    pushd "$NOTES_DIR" &> /dev/null \
        || (echo "ERROR: could not enter '$NOTES_DIR'"; return 1)
    # iterate all files in a directory that start with our search string
    for note_file in "${note_prefix}"*; do
        if [ -d $note_file ]; then
            # The completion matches a directory; add a slash
            note_file+='/'
        elif [ -e "$note_file" ]; then
            # The completion matches a file; add a space
            note_file+=' '
        fi

        # add the file without the to the list of autocomplete suggestions
        COMPREPLY+=("$note_file")
    done

    popd &> /dev/null || return 1
}

# Registers custom autocompletion function to be invoked when completing
# arguments to 'note'. The `-o nospace` option is needed to allow proper
# completions for directory names.
if [ "$(basename "$0")" = "bash" ]; then
    complete -o nospace -F _note_complete note
fi
