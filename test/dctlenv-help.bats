#!/usr/bin/env bats

load "./test_helper"

@test "dctlenv [help|-h|--help]: returns the help message" {
  cases=("help" "-h" "--help")

  for t in ${cases[@]}; do
    run dctlenv $t

    assert_success
    assert_output <<OUT
Usage: dctlenv <command> [<options>]

Commands:
  install           Install a specific version of driftctl
  uninstall         Uninstall a specific version of driftctl
  use               Switch a version to use
  list              List all installed versions
  list-remote       List all installable versions
  version           Display dctlenv version
  help              Show this help output

Flags:
  -v, --version     An alias for the "version" command
  -h, --help        An alias for the "help" command

For full documentation, see: https://github.com/wbeuil/dctlenv#readme
OUT
  done
}
