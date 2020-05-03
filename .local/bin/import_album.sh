#!/usr/bin/env bash
set -e -u -o pipefail

tmp_dir="$(mktemp --directory)"

function cleanup() {
  rm -r "$tmp_dir"
  popd
}
trap cleanup EXIT

function main() {

  zipfile="$(readlink -f "$1")"

  pushd "$tmp_dir" > /dev/null

  unzip -j "$zipfile"

  eyeD3 --plugin=fixup \
    --dir-rename-pattern="$(basename "$tmp_dir")" \
    --file-rename-pattern='$album_artist@@@$album ($best_date:year)@@@$track:num. $title' \
    .

  echo "$?"

  for f in *.mp3; do
    mkdir -p ~/Music/Albums/"$(dirname "${f//@@@/\/}")"
    mv "$f" ~/Music/Albums/"${f//@@@/\/}"
    mv cover.* ~/Music/Albums/"$(dirname "${f//@@@/\/}")" || true
    mv *.pdf ~/Music/Albums/"$(dirname "${f//@@@/\/}")" || true
  done
}

main "$@"
