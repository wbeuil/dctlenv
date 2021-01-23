#!/usr/bin/env bash
set -uo pipefail

log() {
  local text="$2"

  local level="$(echo "$1" | awk '{print toupper($0)}')"

  local date="$(date +"%Y-%m-%d %H:%M:%S")"

  local line="$date [$level] $text"

  case "$1" in
    'info' | 'debug' | 'warn')
      if [ "${DCTLENV_DEBUG:-0}" -gt 0 ]; then
        echo "$line" >&2
      fi
      ;;
    'error')
      if [ "${DCTLENV_DEBUG:-0}" -gt 0 ]; then
        echo "$line" >&2
      fi
      exit 1
      ;;
    *)
      log_error "Undefined log level: $*"
      ;;
  esac
}

log_info() {
  log "info" "$1"
}

log_debug() {
  log "debug" "$1"
}

log_warn() {
  log "warn" "$1"
}

log_error() {
  log "error" "$1"
}
