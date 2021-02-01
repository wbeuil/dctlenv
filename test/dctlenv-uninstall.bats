#!/usr/bin/env bats

load "./test_helper"

setup() {
  export DCTLENV_TMPDIR="$BATS_TMPDIR/dctlenv"
  export DCTLENV_TMPDIR="$(mktemp -d "$DCTLENV_TMPDIR.XXX" 2>/dev/null || echo "$DCTLENV_TMPDIR")"
  export DCTLENV_ROOT="$DCTLENV_TMPDIR"

  dctlenv-list() {
    echo "  0.3.1
  0.3.0
  0.2.3"
  }
  export -f dctlenv-list;
}

@test "dctlenv uninstall [<version>]: prints an error message if we try to uninstall more than one version" {
  run dctlenv uninstall 0.3.1 0.3.0

  assert_failure
  assert_output 'usage: dctlenv uninstall [<version>]'
}

@test "dctlenv uninstall [<version>]: prints an error message if there is no version to uninstall" {
  run dctlenv uninstall

  assert_failure
  assert_output 'usage: dctlenv uninstall [<version>]'
}

@test "dctlenv uninstall [<version>]: prints an error message if the version requested doesn't exist in local" {
  mkdir -p "$DCTLENV_TMPDIR/versions/0.3.1"
  mkdir -p "$DCTLENV_TMPDIR/versions/0.3.0"
  mkdir -p "$DCTLENV_TMPDIR/versions/0.2.3"

  run dctlenv uninstall 0.0.0

  assert_failure
  assert_output "No versions matching '0.0.0' found in local"
}

@test "dctlenv uninstall [<version>]: prints a success message at the end of the uninstall" {
  mkdir -p "$DCTLENV_TMPDIR/versions/0.3.1"
  mkdir -p "$DCTLENV_TMPDIR/versions/0.3.0"
  mkdir -p "$DCTLENV_TMPDIR/versions/0.2.3"
  touch "$DCTLENV_TMPDIR/versions/0.3.1/driftctl"

  run dctlenv uninstall 0.3.1

  assert_success
  assert_output <<OUT
Uninstall driftctl v0.3.1
driftctl v0.3.1 is successfully uninstalled
OUT
}

teardown() {
  rm -rf "$DCTLENV_TMPDIR"
}
