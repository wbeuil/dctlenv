# fish completion for dctlenv

set -l commands help install list list-remote uninstall use version

complete -f -c dctlenv -n "not __fish_seen_subcommand_from $commands" -a help -d 'Show the help output'
complete -f -c dctlenv -n "not __fish_seen_subcommand_from $commands" -a install -d 'Install a specific version of driftctl'
complete -f -c dctlenv -n "not __fish_seen_subcommand_from $commands" -a list -d 'List all installed versions'
complete -f -c dctlenv -n "not __fish_seen_subcommand_from $commands" -a list-remote -d 'List all installable versions'
complete -f -c dctlenv -n "not __fish_seen_subcommand_from $commands" -a uninstall -d 'Uninstall a specific version of driftctl'
complete -f -c dctlenv -n "not __fish_seen_subcommand_from $commands" -a use -d 'Switch a version to use'
complete -f -c dctlenv -n "not __fish_seen_subcommand_from $commands" -a version -d 'Display dctlenv version'
