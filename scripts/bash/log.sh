#!/usr/bin/env bash
set -eEu
set -o pipefail

do_log() {
    cut -f 2 -d ' ' "$log_file" | sort -n | uniq -c | sort -nr
}

main() {
  set +u
  log_file="$1"
  if [[ -z "$log_file" ]]; then
    echo "usage: log.sh <log file>"
    exit 1
  fi
  set -u
  do_log
}

main "$@"
