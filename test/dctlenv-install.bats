#!/usr/bin/env bats

load "./test_helper"

setup() {
  export DCTLENV_TMPDIR="$BATS_TMPDIR/dctlenv"
  export DCTLENV_TMPDIR="$(mktemp -d "$DCTLENV_TMPDIR.XXX" 2>/dev/null || echo "$DCTLENV_TMPDIR")"
  export DCTLENV_ROOT="$DCTLENV_TMPDIR"
  export DCTLENV_PGP=0

  dctlenv-list-remote() {
    echo "0.1.0
0.1.1
0.2.0
0.2.1
0.2.2
0.2.3
0.3.0
0.3.1"
  }
  export -f dctlenv-list-remote;
}

@test "dctlenv install [<version>]: prints an error message if we try to install more than one version" {
  run dctlenv install 0.3.1 0.3.0

  assert_failure
  assert_output 'usage: dctlenv install [<version>]'
}

@test "dctlenv install [<version>]: prints an error message if there is no version to install" {
  run dctlenv install

  assert_failure
  assert_output 'usage: dctlenv install [<version>]'
}

@test "dctlenv install [<version>]: prints an error message if the version requested doesn't exist" {
  run dctlenv install 0.0.0

  assert_failure
  assert_output 'No version 0.0.0 found in remote'
}

@test "dctlenv install [<version>]: prints a message when the version is already installed" {
  mkdir -p "$DCTLENV_TMPDIR/versions/0.3.1"
  touch "$DCTLENV_TMPDIR/versions/0.3.1/driftctl"

  run dctlenv install 0.3.1

  assert_success
  assert_output 'driftctl v0.3.1 is already installed'
}

@test "dctlenv install [<version>]: prints an error message if it failed to download the tarball" {
  curlw() { exit 1; }; export -f curlw;
  uname() { echo "Linux"; }; export -f uname;

  run dctlenv install 0.3.1

  assert_failure
  assert_output <<OUT
Installing driftctl v0.3.1
Downloading release tarball from https://github.com/snyk/driftctl/releases/download/v0.3.1/driftctl_linux_amd64
Tarball download failed
OUT
}

@test "dctlenv install [<version>]: prints an error message if it failed to make the binary executable" {
  chmod() { exit 1; }; export -f chmod;
  uname() { echo "Linux"; }; export -f uname;
  curlw() {
    mkdir -p "$DCTLENV_TMPDIR/versions/0.3.1"
    touch "$DCTLENV_TMPDIR/versions/0.3.1/driftctl_linux_amd64"
    exit 0
  }; export -f curlw;

  run dctlenv install 0.3.1

  assert_failure
  assert_output <<OUT
Installing driftctl v0.3.1
Downloading release tarball from https://github.com/snyk/driftctl/releases/download/v0.3.1/driftctl_linux_amd64
Downloading SHA256 hashes file from https://github.com/snyk/driftctl/releases/download/v0.3.1/driftctl_SHA256SUMS
No SHA256 hashes file available. Skipping SHA256 hash validation
Fail to make the binary executable
OUT
  refute [ -e "$DCTLENV_TMPDIR/versions/0.3.1/driftctl_SHA256SUMS" ]
}

@test "dctlenv install [<version>]: prints a success message at the end of the install" {
  chmod() { exit 0; }; export -f chmod;
  uname() { echo "Linux"; }; export -f uname;
  curlw() {
    mkdir -p "$DCTLENV_TMPDIR/versions/0.3.1"
    touch "$DCTLENV_TMPDIR/versions/0.3.1/driftctl_linux_amd64"
    exit 0
  }; export -f curlw;

  run dctlenv install 0.3.1

  assert_success
  assert_output <<OUT
Installing driftctl v0.3.1
Downloading release tarball from https://github.com/snyk/driftctl/releases/download/v0.3.1/driftctl_linux_amd64
Downloading SHA256 hashes file from https://github.com/snyk/driftctl/releases/download/v0.3.1/driftctl_SHA256SUMS
No SHA256 hashes file available. Skipping SHA256 hash validation
Installation of driftctl v0.3.1 successful. To make this your default version, run 'dctlenv use 0.3.1'
OUT
  refute [ -e "$DCTLENV_TMPDIR/versions/0.3.1/driftctl_SHA256SUMS" ]
}

@test "dctlenv install [<version>]: prints an error message if it failed to check SHA256" {
  uname() { echo "Linux"; }; export -f uname;
  curlw() {
    mkdir -p "$DCTLENV_TMPDIR/versions/0.3.1"
    touch "$DCTLENV_TMPDIR/versions/0.3.1/driftctl_linux_amd64"
    echo "test driftctl_linux_amd64" > "$DCTLENV_TMPDIR/versions/0.3.1/driftctl_SHA256SUMS"
    exit 0
  }; export -f curlw;

  run dctlenv install 0.3.1

  assert_failure
  assert_output <<OUT
Installing driftctl v0.3.1
Downloading release tarball from https://github.com/snyk/driftctl/releases/download/v0.3.1/driftctl_linux_amd64
Downloading SHA256 hashes file from https://github.com/snyk/driftctl/releases/download/v0.3.1/driftctl_SHA256SUMS
SHA256 hash does not match!
OUT
  assert [ -e "$DCTLENV_TMPDIR/versions/0.3.1/driftctl_SHA256SUMS" ]
}

@test "dctlenv install [<version>]: prints a success message if it can install and check for SHA256" {
  uname() { echo "Linux"; }; export -f uname;
  curlw() {
    mkdir -p "$DCTLENV_TMPDIR/versions/0.3.1"
    touch "$DCTLENV_TMPDIR/versions/0.3.1/driftctl_linux_amd64"
    (cd "$DCTLENV_TMPDIR/versions/0.3.1"; sha256sum * > "$DCTLENV_TMPDIR/versions/0.3.1/driftctl_SHA256SUMS")
    exit 0
  }; export -f curlw;

  run dctlenv install 0.3.1

  assert_success
  assert_output <<OUT
Installing driftctl v0.3.1
Downloading release tarball from https://github.com/snyk/driftctl/releases/download/v0.3.1/driftctl_linux_amd64
Downloading SHA256 hashes file from https://github.com/snyk/driftctl/releases/download/v0.3.1/driftctl_SHA256SUMS
SHA256 hash matched!
Installation of driftctl v0.3.1 successful. To make this your default version, run 'dctlenv use 0.3.1'
OUT
  refute [ -e "$DCTLENV_TMPDIR/versions/0.3.1/driftctl_SHA256SUMS" ]
}

@test "dctlenv install [<version>]: prints a success message if it can install v0.3.1" {
  uname() { echo "Linux"; }; export -f uname;
  curlw() {
    mkdir -p "$DCTLENV_TMPDIR/versions/0.3.1"
    touch "$DCTLENV_TMPDIR/versions/0.3.1/driftctl_linux_amd64"
    (cd "$DCTLENV_TMPDIR/versions/0.3.1"; sha256sum * > "$DCTLENV_TMPDIR/versions/0.3.1/driftctl_SHA256SUMS")
    exit 0
  }; export -f curlw;

  run dctlenv install v0.3.1

  assert_success
  assert_output <<OUT
Installing driftctl v0.3.1
Downloading release tarball from https://github.com/snyk/driftctl/releases/download/v0.3.1/driftctl_linux_amd64
Downloading SHA256 hashes file from https://github.com/snyk/driftctl/releases/download/v0.3.1/driftctl_SHA256SUMS
SHA256 hash matched!
Installation of driftctl v0.3.1 successful. To make this your default version, run 'dctlenv use 0.3.1'
OUT
  refute [ -e "$DCTLENV_TMPDIR/versions/0.3.1/driftctl_SHA256SUMS" ]
}

@test "dctlenv install [<version>]: prints a success message if it can install the latest version" {
  uname() { echo "Linux"; }; export -f uname;
  curlw() {
    mkdir -p "$DCTLENV_TMPDIR/versions/0.3.1"
    touch "$DCTLENV_TMPDIR/versions/0.3.1/driftctl_linux_amd64"
    (cd "$DCTLENV_TMPDIR/versions/0.3.1"; sha256sum * > "$DCTLENV_TMPDIR/versions/0.3.1/driftctl_SHA256SUMS")
    exit 0
  }; export -f curlw;

  run dctlenv install latest

  assert_success
  assert_output <<OUT
Installing driftctl v0.3.1
Downloading release tarball from https://github.com/snyk/driftctl/releases/download/v0.3.1/driftctl_linux_amd64
Downloading SHA256 hashes file from https://github.com/snyk/driftctl/releases/download/v0.3.1/driftctl_SHA256SUMS
SHA256 hash matched!
Installation of driftctl v0.3.1 successful. To make this your default version, run 'dctlenv use 0.3.1'
OUT
  refute [ -e "$DCTLENV_TMPDIR/versions/0.3.1/driftctl_SHA256SUMS" ]
}

@test "dctlenv install [<version>]: prints a missing hashes signature file" {
  uname() { echo "Linux"; }; export -f uname;
  curlw() {
    mkdir -p "$DCTLENV_TMPDIR/versions/0.3.1"
    touch "$DCTLENV_TMPDIR/versions/0.3.1/driftctl_linux_amd64"
    (cd "$DCTLENV_TMPDIR/versions/0.3.1"; sha256sum * > "$DCTLENV_TMPDIR/versions/0.3.1/driftctl_SHA256SUMS")
    exit 0
  }; export -f curlw;

  DCTLENV_PGP=1 run dctlenv install 0.3.1

  assert_success
  assert_output <<OUT
Installing driftctl v0.3.1
Downloading release tarball from https://github.com/snyk/driftctl/releases/download/v0.3.1/driftctl_linux_amd64
Downloading SHA256 hashes file from https://github.com/snyk/driftctl/releases/download/v0.3.1/driftctl_SHA256SUMS
SHA256 hash matched!
Downloading SHA256 hashes signature file from https://github.com/snyk/driftctl/releases/download/v0.3.1/driftctl_SHA256SUMS.gpg
No SHA256 hashes signature file available. Skipping signature validation
Installation of driftctl v0.3.1 successful. To make this your default version, run 'dctlenv use 0.3.1'
OUT
  refute [ -e "$DCTLENV_TMPDIR/versions/0.3.1/driftctl_SHA256SUMS" ]
  refute [ -e "$DCTLENV_TMPDIR/versions/0.3.1/driftctl_SHA256SUMS.gpg" ]
}

@test "dctlenv install [<version>]: prints an error message if the PGP signature check fails" {
  uname() { echo "Linux"; }; export -f uname;
  curlw() {
    mkdir -p "$DCTLENV_TMPDIR/versions/0.3.1"
    touch "$DCTLENV_TMPDIR/versions/0.3.1/driftctl_linux_amd64"
    (cd "$DCTLENV_TMPDIR/versions/0.3.1"; sha256sum * > "$DCTLENV_TMPDIR/versions/0.3.1/driftctl_SHA256SUMS")
    touch "$DCTLENV_TMPDIR/versions/0.3.1/driftctl_SHA256SUMS.gpg"
    exit 0
  }; export -f curlw;
  gpg() { exit 1; }; export -f gpg;

  DCTLENV_PGP=1 run dctlenv install 0.3.1

  assert_failure
  assert_output <<OUT
Installing driftctl v0.3.1
Downloading release tarball from https://github.com/snyk/driftctl/releases/download/v0.3.1/driftctl_linux_amd64
Downloading SHA256 hashes file from https://github.com/snyk/driftctl/releases/download/v0.3.1/driftctl_SHA256SUMS
SHA256 hash matched!
Downloading SHA256 hashes signature file from https://github.com/snyk/driftctl/releases/download/v0.3.1/driftctl_SHA256SUMS.gpg
PGP signature rejected!
OUT
  assert [ -e "$DCTLENV_TMPDIR/versions/0.3.1/driftctl_SHA256SUMS" ]
  assert [ -e "$DCTLENV_TMPDIR/versions/0.3.1/driftctl_SHA256SUMS.gpg" ]
}

@test "dctlenv install [<version>]: prints a success message if the PGP signature check matches" {
  uname() { echo "Linux"; }; export -f uname;
  curlw() {
    mkdir -p "$DCTLENV_TMPDIR/versions/0.3.1"
    touch "$DCTLENV_TMPDIR/versions/0.3.1/driftctl_linux_amd64"
    (cd "$DCTLENV_TMPDIR/versions/0.3.1"; sha256sum * > "$DCTLENV_TMPDIR/versions/0.3.1/driftctl_SHA256SUMS")
    touch "$DCTLENV_TMPDIR/versions/0.3.1/driftctl_SHA256SUMS.gpg"
    exit 0
  }; export -f curlw;
  gpg() { exit 0; }; export -f gpg;

  DCTLENV_PGP=1 run dctlenv install 0.3.1

  assert_success
  assert_output <<OUT
Installing driftctl v0.3.1
Downloading release tarball from https://github.com/snyk/driftctl/releases/download/v0.3.1/driftctl_linux_amd64
Downloading SHA256 hashes file from https://github.com/snyk/driftctl/releases/download/v0.3.1/driftctl_SHA256SUMS
SHA256 hash matched!
Downloading SHA256 hashes signature file from https://github.com/snyk/driftctl/releases/download/v0.3.1/driftctl_SHA256SUMS.gpg
PGP signature matched!
Installation of driftctl v0.3.1 successful. To make this your default version, run 'dctlenv use 0.3.1'
OUT
  refute [ -e "$DCTLENV_TMPDIR/versions/0.3.1/driftctl_SHA256SUMS" ]
  refute [ -e "$DCTLENV_TMPDIR/versions/0.3.1/driftctl_SHA256SUMS.gpg" ]
}

teardown() {
  rm -rf "$DCTLENV_TMPDIR"
}
