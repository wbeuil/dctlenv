load 'libs/bats-support/load'
load 'libs/bats-assert/load'

load "../lib/log.sh"

PATH="$BATS_TEST_DIRNAME/../libexec:$PATH"
export PATH
