#!/usr/bin/env bats

load "./test_helper"

@test "dctlenv: prints help when no command argument is given" {
  run dctlenv

  assert_success
  assert_output <<OUT
$(dctlenv-version)

$(dctlenv-help)
OUT
}

@test "dctlenv: fails when invalid command argument is given" {
  run dctlenv foo

  assert_failure
  assert_output <<OUT
dctlenv: unknown command "foo"

$(dctlenv-help)
OUT
}
