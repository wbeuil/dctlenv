#!/usr/bin/env bats

load "./test_helper"

@test "dctlenv root: returns current DCTLENV_ROOT" {
  DCTLENV_ROOT=/tmp/dctlenv run dctlenv root

  assert_success
  assert_output '/tmp/dctlenv'
}
