#compdef _dctlenv dctlenv

_dctlenv() {
  local -a commands

  _arguments -C \
    "1: :->cmnds"

  case $state in
  cmnds)
    commands=(
      "install:Install a specific version of driftctl"
      "uninstall:Uninstall a specific version of driftctl"
      "use:Switch a version to use"
      "list:List all installed versions"
      "list-remote:List all installable versions"
      "version:Display dctlenv version"
      "help:Show the help output"
    )
    _describe "command" commands
    ;;
  esac
}
