#!/usr/bin/env bats

load "./test_helper"

@test "dctlenv version-file: returns current version file" {
  DCTLENV_ROOT=/tmp/dctlenv run dctlenv version-file

  assert_success
  assert_output '/tmp/dctlenv/version'
}
