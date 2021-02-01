#!/usr/bin/env bats

load "./test_helper"

@test "dctlenv list-remote: prints an error message if curl command failed" {
  curlw() { exit 1; }; export -f curlw;

  run dctlenv list-remote

  assert_failure
  assert_output 'Failed to download remote versions from GitHub'
}

@test "dctlenv list-remote: returns a list of all installable versions" {
  curlw() { echo "$(cat ./test/mocks/list-remote.json)"; }; export -f curlw;

  run dctlenv list-remote

  assert_success
  assert_output <<OUT
0.1.0
0.1.1
0.2.0
0.2.1
0.2.2
0.2.3
0.3.0
0.3.1
OUT
}
