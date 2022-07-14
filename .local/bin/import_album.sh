#!/usr/bin/env bash
set -e -u -o pipefail

tmp_dir="$(mktemp --directory)"

function cleanup() {
  rm -r "$tmp_dir"
  popd
}
trap cleanup EXIT

function continue_prompt() {
  cmd="${1:-Previous command}"
  read -r -p "$cmd may have failed. Continue anyway? [y/N]: " response
  case "$response" in
    [yY][eE][sS]|[yY]) true;;
    *) exit 1;
  esac
}

function main() {

  if [[ "$1" =~ *.zip ]]; then
    zipfile="$(readlink -f "$1")"
    unzip -j "$zipfile" -d "$tmp_dir" || continue_prompt Unzip
  elif [[ -d "$1" ]]; then
    cp -rp "$1"/* "$tmp_dir"/
  else
    echo "ERROR: unexpected input"
    exit 1
  fi

  pushd "$tmp_dir" > /dev/null

  eyeD3 --plugin=fixup \
    --dir-rename-pattern="$(basename "$tmp_dir")" \
    --file-rename-pattern='$album_artist@@@$album@@@$track:num. $title' \
    .

  echo "$?"

  for f in *.mp3 *.m4a *.ogg; do
    mkdir -p ~/Music/Albums/"$(dirname "${f//@@@/\/}")"
    mv "$f" ~/Music/Albums/"${f//@@@/\/}"
    mv cover.* ~/Music/Albums/"$(dirname "${f//@@@/\/}")" || true
    mv *.pdf ~/Music/Albums/"$(dirname "${f//@@@/\/}")" || true
  done
}

main "$@"
