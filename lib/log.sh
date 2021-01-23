#!/usr/bin/env bash
set -uo pipefail

log() {
  local text="$2"

  local level="$(echo "$1" | awk '{print toupper($0)}')"

  local date="$(date +"%Y-%m-%d %H:%M:%S")"

  local line="$date [$level] $text"

  local usage="${3:-""}"

  case "$1" in
    'info' | 'debug' | 'warn')
      if [ "${DCTLENV_DEBUG:-0}" -gt 0 ]; then
        echo -e "$line" >&2
      fi
      ;;
    'error')
      if [ "${DCTLENV_DEBUG:-0}" -gt 0 ]; then
        echo -e "$line" >&2
      fi
      echo -e "$usage" >&2
      exit 1
      ;;
    *)
      log_error "Undefined log level: $*"
      ;;
  esac
}
export -f log

log_info() {
  log "info" "$1"
}
export -f log_info

log_debug() {
  log "debug" "$1"
}
export -f log_debug

log_warn() {
  log "warn" "$1"
}
export -f log_warn

log_error() {
  local usage="${2:-$1}"

  log "error" "$1" "$usage"
}
export -f log_error
