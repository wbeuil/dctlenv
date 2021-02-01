#!/usr/bin/env bats

load "./test_helper"

setup() {
  export DCTLENV_TMPDIR="$BATS_TMPDIR/dctlenv"
  export DCTLENV_TMPDIR="$(mktemp -d "$DCTLENV_TMPDIR.XXX" 2>/dev/null || echo "$DCTLENV_TMPDIR")"
  export DCTLENV_ROOT="$DCTLENV_TMPDIR"
}

@test "dctlenv version-name: prints an error message if directory DCTLENV_ROOT/versions does not exist" {
  run dctlenv version-name

  assert_failure
  assert_output 'No versions of driftctl installed. Please install one with: dctlenv install [<version>]'
}

@test "dctlenv version-name: prints an error message if file DCTLENV_ROOT/version could not be read" {
  mkdir -p "$DCTLENV_TMPDIR/versions"

  run dctlenv version-name

  assert_failure
  assert_output "Version could not be resolved (set by $DCTLENV_ROOT/version or dctlenv use <version>)"
}

@test "dctlenv version-name: prints an error message when no version is present in DCTLENV_ROOT/versions" {
  mkdir -p "$DCTLENV_TMPDIR/versions"
  echo "0.0.1" > "$DCTLENV_ROOT/version"

  run dctlenv version-name

  assert_failure
  assert_output "Version '0.0.1' is not installed (set by $DCTLENV_ROOT/version)"
}

@test "dctlenv version-name: prints the installed version" {
  mkdir -p "$DCTLENV_TMPDIR/versions/0.0.1"
  echo "0.0.1" > "$DCTLENV_ROOT/version"

  run dctlenv version-name

  assert_success
  assert_output "0.0.1"
}

teardown() {
  rm -rf "$DCTLENV_TMPDIR"
}
