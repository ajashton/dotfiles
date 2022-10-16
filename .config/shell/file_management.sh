# Rename file(s) to {orginial_name}.bak
function bak() {
  for file in "$@"; do
    mv "$file"{,.bak}
  done
}

# Follow copied and moved files to destination directory (courtesy jwr)
follow() {
  if [ -d "$1" ]; then
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
      # For zip files, ignore any extra MacOS cruft.
      # There does not seem to be a good way to silence the noise caused by
      # the -x flag for cases where the zip does not contain matching files,
      # but I'd rather have extra terminal noise than extra filesystem garbage.
      *.zip)    unzip "$1" -x '__MACOSX/*' '*.DS_Store';;
      *.zst)    unzst "$1";;
      *) echo "'$1' cannot be extracted by xt";;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}

