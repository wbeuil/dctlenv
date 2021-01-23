#!/usr/bin/env bash
set -uo pipefail

source "$DCTLENV_ROOT/lib/log.sh"

# Curl wrapper to switch TLS option for each OS
curlw() {
  local TLS_OPT="--tlsv1.2"

  # Check if curl is 10.12.6 or above
  if [[ -n "$(command -v sw_vers 2>/dev/null)" && ("$(sw_vers)" =~ 10\.12\.([6-9]|[0-9]{2}) || "$(sw_vers)" =~ 10\.1[3-9]) ]]; then
    TLS_OPT=""
  fi

  curl $TLS_OPT "$@"
}
export -f curlw
