#!/usr/bin/env bats

load "./test_helper"

setup() {
  export DCTLENV_TMPDIR="$BATS_TMPDIR/dctlenv"
  export DCTLENV_TMPDIR="$(mktemp -d "$DCTLENV_TMPDIR.XXX" 2>/dev/null || echo "$DCTLENV_TMPDIR")"
  export DCTLENV_ROOT="$DCTLENV_TMPDIR"
}

@test "dctlenv exec: prints an error message it can't get the version" {
  run dctlenv exec

  assert_failure
  assert_output 'Failed to get version from dctlenv-version-name'
}

@test "dctlenv exec: prints error messages if it fails to execute" {
  mkdir -p "$DCTLENV_TMPDIR/versions/0.3.1"
  echo "echo 'Usage: driftctl <command> [flags]'" > "$DCTLENV_TMPDIR/versions/0.3.1/driftctl"
  echo "0.3.1" > "$DCTLENV_ROOT/version"

  run dctlenv exec

  assert_failure
}

@test "dctlenv exec: execute successfuly driftctl commands" {
  mkdir -p "$DCTLENV_TMPDIR/versions/0.3.1"
  echo "echo 'Usage: driftctl <command> [flags]'" > "$DCTLENV_TMPDIR/versions/0.3.1/driftctl"
  chmod +x $DCTLENV_TMPDIR/versions/0.3.1/driftctl
  echo "0.3.1" > "$DCTLENV_ROOT/version"

  run dctlenv exec

  assert_success
  assert_output 'Usage: driftctl <command> [flags]'
}

teardown() {
  rm -rf "$DCTLENV_TMPDIR"
}
