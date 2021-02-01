#!/usr/bin/env bats

load "./test_helper"

expected_version="dctlenv 0.0.4-2-gc013c6c"

@test "dctlenv [version|-v|--version]: returns the expected version" {
  cases=("version" "-v" "--version")

  for t in ${cases[@]}; do
    run dctlenv $t

    assert_success "$expected_version"
  done
}
