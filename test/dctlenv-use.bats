#!/usr/bin/env bats

load "./test_helper"

setup() {
  export DCTLENV_TMPDIR="$BATS_TMPDIR/dctlenv"
  export DCTLENV_TMPDIR="$(mktemp -d "$DCTLENV_TMPDIR.XXX" 2>/dev/null || echo "$DCTLENV_TMPDIR")"
  export DCTLENV_ROOT="$DCTLENV_TMPDIR"
}

@test "dctlenv use [<version>]: prints an error message if we try to use more than one version" {
  run dctlenv use 0.3.1 0.3.0

  assert_failure
  assert_output 'usage: dctlenv use [<version>]'
}

@test "dctlenv use [<version>]: prints an error message if there is no version installed" {
  run dctlenv use 0.3.1

  assert_failure
  assert_output 'No versions of driftctl installed. Please install one with: dctlenv install [<version>]'
}

@test "dctlenv use [<version>]: prints an error message if we don't specified a version to use" {
  mkdir -p "$DCTLENV_TMPDIR/versions/0.3.1"

  run dctlenv use

  assert_failure
  assert_output 'usage: dctlenv use [<version>]'
}

@test "dctlenv use [<version>]: prints an error message if we try to use a non-installed version" {
  mkdir -p "$DCTLENV_TMPDIR/versions/0.3.1"

  run dctlenv use 0.3.0

  assert_failure
  assert_output "No installed versions of driftctl matched '0.3.0'"
}

@test "dctlenv use [<version>]: prints an error message if we try to use a version where its binary is not present" {
  mkdir -p "$DCTLENV_TMPDIR/versions/0.3.1"

  run dctlenv use 0.3.1

  assert_failure
  assert_output "Version directory for 0.3.1 is present, but the driftctl binary is not! Manual intervention required"
}

@test "dctlenv use [<version>]: prints an error message if we try to use a version where its binary is not executable" {
  mkdir -p "$DCTLENV_TMPDIR/versions/0.3.1"
  touch "$DCTLENV_TMPDIR/versions/0.3.1/driftctl"

  run dctlenv use 0.3.1

  assert_failure
  assert_output "Version directory for 0.3.1 is present, but the driftctl binary is not executable! Manual intervention required"
}

@test "dctlenv use [<version>]: prints a success message when switching versions" {
  mkdir -p "$DCTLENV_TMPDIR/versions/0.3.1"
  touch "$DCTLENV_TMPDIR/versions/0.3.1/driftctl"
  chmod +x $DCTLENV_TMPDIR/versions/0.3.1/driftctl

  driftctl() { exit 0; }; export -f driftctl;

  run dctlenv use 0.3.1

  assert_success
  assert_output <<OUT
Switching version to v0.3.1
Switching completed
OUT
}

teardown() {
  rm -rf "$DCTLENV_TMPDIR"
}
