# dctlenv

Version manager for [driftctl](https://github.com/cloudskiff/driftctl) inspired by [tfenv](https://github.com/tfutils/tfenv).

## Installation

### Basic GitHub Checkout

This will get you going with the latest version of dctlenv and make it easy to fork and contribute any changes back upstream.

**1. Check out dctlenv where you want**

```shell
$ git clone https://github.com/wbeuil/dctlenv ~/.dctlenv
```

**2. Add `~/.dctlenv/bin` to your `$PATH` for access to the dctlenv CLI**

- For **Bash**:

```shell
$ echo 'export PATH="$HOME/.dctlenv/bin:$PATH"' >> ~/.bash_profile
```

- For **Zsh**:

```shell
$ echo 'export PATH="$HOME/.dctlenv/bin:$PATH"' >> ~/.zshrc
```

- For **Fish**:

```shell
$ set -Ux fish_user_paths $HOME/.dctlenv/bin $fish_user_paths
```

**3. Restart your shell so that PATH changes take effect**

#### Upgrading With Git

If you've installed dctlenv using the instructions above, you can upgrade to the latest version by pulling from GitHub.

```shell
$ cd ~/.dctlenv
$ git pull
```

## Command Reference

### `dctlenv install [<version>]`

Install a specific version of driftctl.

```shell
$ dctlenv install 0.2.3
Installing driftctl v0.2.3
Downloading release tarball from https://github.com/cloudskiff/driftctl/releases/download/v0.2.3/driftctl_darwin_amd64
######################################################################################################################## 100.0%
Making the /home/wbeuil/.dctlenv/versions/0.2.3/driftctl binary executable
Installation of driftctl v0.2.3 successful. To make this your default version, run 'dctlenv use 0.2.3'
```

### `dctlenv use [<version>]`

Switch a version to use.

```shell
$ dctlenv use 0.2.3
Switching version to v0.2.3
Switching completed
```

### `dctlenv list`

List installed versions.

```shell
$ dctlenv list
* 0.2.3 (set by /home/wbeuil/.dctlenv/version)
  0.2.2
```

### `dctlenv list-remote`

List all installable versions.

```shell
$ dctlenv list-remote
0.1.0
0.1.1
0.2.0
0.2.1
0.2.2
0.2.3
```

### `dctlenv uninstall [<version>]`

Uninstall a specific version of driftctl.

```shell
$ dctlenv uninstall 0.2.3
Uninstall driftctl v0.2.3
driftctl v0.2.3 is successfully uninstalled
```

### `dctlenv root`

Display the root directory where dctlenv is.

```shell
$ dctlenv root
/home/wbeuil/.dctlenv
```

### `dctlenv [version|-v|--version]`

Display dctlenv version.

```shell
$ dctlenv version
dctlenv 0.0.2-1-gabff053
```

### `dctlenv [help|-h|--help]`

Display dctlenv help and usage contents.

```shell
$ dctlenv help
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
```

## Uninstalling dctlenv

You will need to first remove the line from your shell startup configuration file. This will remove dctlenv from your `$PATH`.

Then, you just need to remove its root directory:

```shell
$ rm -rf `dctlenv root`
```
