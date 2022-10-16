# Functions to perform various types of calculations

# sum a list of numbers
function total() {
  python -c "import re; import sys; print(sum([float(n) for n in sys.stdin if re.match('^\s*-?([0-9]+[.])?[0-9]+\s*', n)]))"
}

# tcalc: a time calculator using PostgreSQL
# example: `tcalc 10:41:02 + 16h43m` → 27:24:02
function tcalc() {
  local query="select interval '"
  query+="$(sed $'s,\(\\s*[-+]\\s*\),\' \\1\ interval \',g' <<< "$@")"
  query+="';"
  psql -AqtX -c "$query"
}
