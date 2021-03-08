#!/usr/bin/env bats

load "./test_helper"

setup() {
  export DCTLENV_TMPDIR="$BATS_TMPDIR/dctlenv"
  export DCTLENV_TMPDIR="$(mktemp -d "$DCTLENV_TMPDIR.XXX" 2>/dev/null || echo "$DCTLENV_TMPDIR")"
  export DCTLENV_ROOT="$DCTLENV_TMPDIR"
}

@test "dctlenv list: prints an error message if no versions is installed" {
  run dctlenv list

  assert_failure
  assert_output 'No versions of driftctl installed. Please install one with: dctlenv install [<version>]'
}

@test "dctlenv list: prints all installed versions" {
  curlw() { echo "$(cat ./test/mocks/list-remote.json)"; }; export -f curlw;

  mkdir -p "$DCTLENV_TMPDIR/versions/0.3.1"
  mkdir -p "$DCTLENV_TMPDIR/versions/0.3.0"
  mkdir -p "$DCTLENV_TMPDIR/versions/0.2.3"
  echo "0.3.1" > "$DCTLENV_ROOT/version"

  run dctlenv list

  assert_success
  assert_output <<OUT
* 0.3.1 (set by $DCTLENV_ROOT/version)
  0.3.0
  0.2.3
OUT
}

@test "dctlenv list: prints all installed versions without a used version" {
  curlw() { echo "$(cat ./test/mocks/list-remote.json)"; }; export -f curlw;

  mkdir -p "$DCTLENV_TMPDIR/versions/0.3.1"
  mkdir -p "$DCTLENV_TMPDIR/versions/0.3.0"
  mkdir -p "$DCTLENV_TMPDIR/versions/0.2.3"

  run dctlenv list

  assert_success
  assert_output <<OUT
  0.3.1
  0.3.0
  0.2.3
OUT
}

teardown() {
  rm -rf "$DCTLENV_TMPDIR"
}
