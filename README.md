# dctlenv

Version manager for [driftctl](https://github.com/cloudskiff/driftctl) inspired by [tfenv](https://github.com/tfutils/tfenv).

## Installation

### Basic GitHub Checkout

This will get you going with the latest version of dctlenv and make it easy to fork and contribute any changes back upstream.

**1. Check out dctlenv where you want**

```console
$ git clone https://github.com/wbeuil/dctlenv ~/.dctlenv
```

**2. Add `~/.dctlenv/bin` to your `$PATH` for access to the dctlenv CLI**

- For **Bash**:

```console
$ echo 'export PATH="$HOME/.dctlenv/bin:$PATH"' >> ~/.bash_profile
```

- For **Zsh**:

```console
$ echo 'export PATH="$HOME/.dctlenv/bin:$PATH"' >> ~/.zshrc
```

- For **Fish**:

```console
$ set -Ux fish_user_paths $HOME/.dctlenv/bin $fish_user_paths
```

**3. Restart your shell so that PATH changes take effect**

#### Upgrading With Git

If you've installed dctlenv using the instructions above, you can upgrade to the latest version by pulling from GitHub.

```console
$ cd ~/.dctlenv
$ git pull
```

## Command Reference

### `dctlenv install [<version>]`

Install a specific version of driftctl.

```console
$ dctlenv install 0.2.3
Installing driftctl v0.2.3
Downloading release tarball from https://github.com/cloudskiff/driftctl/releases/download/v0.2.3/driftctl_darwin_amd64
######################################################################################################################## 100.0%
Making the /home/wbeuil/.dctlenv/versions/0.2.3/driftctl binary executable
Installation of driftctl v0.2.3 successful. To make this your default version, run 'dctlenv use 0.2.3'
```

### `dctlenv use [<version>]`

Switch a version to use.

```console
$ dctlenv use 0.2.3
Switching version to v0.2.3
Switching completed
```

### `dctlenv list`

List installed versions.

```console
$ dctlenv list
* 0.2.3 (set by /home/wbeuil/.dctlenv/version)
  0.2.2
```

### `dctlenv list-remote`

List all installable versions.

```console
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

```console
$ dctlenv uninstall 0.2.3
Uninstall driftctl v0.2.3
driftctl v0.2.3 is successfully uninstalled
```

### `dctlenv root`

Display the root directory where dctlenv is.

```console
$ dctlenv root
/home/wbeuil/.dctlenv
```

### `dctlenv [version|-v|--version]`

Display dctlenv version.

```console
$ dctlenv version
dctlenv 0.0.2-1-gabff053
```

### `dctlenv [help|-h|--help]`

Display dctlenv help and usage contents.

```console
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

```console
$ rm -rf `dctlenv root`
```

## Completion scripts

Completion scripts are available to use inside the `completions` folder.

### Bash

```console
# Linux:
$ sudo cp completions/dctlenv.bash /etc/bash_completion.d/dctlenv

# MacOS:
$ sudo cp completions/dctlenv.bash /usr/local/etc/bash_completion.d/dctlenv
```

Remember to open a new shell to test the functionality.

### Zsh

If shell completion is not already enabled in your environment, you will need to enable it. You can execute the following once:

```console
$ echo "autoload -U compinit; compinit" >> ~/.zshrc
```

Then, place the completion script in your completion folder listed in your `fpath` if it already exists. Otherwise, you can create a directory, add it to your `fpath` and copy the file in it:

```console
$ cp completions/dctlenv.zsh > fpath/completion_folder/_dctlenv
```

#### Oh-My-Zsh

```console
$ mkdir -p ~/.oh-my-zsh/completions
$ cp completions/dctlenv.zsh ~/.oh-my-zsh/completions/_dctlenv
```

You will need to start a new shell for this setup to take effect.

### Fish

```console
$ cp completions/dctlenv.fish ~/.config/fish/completions/dctlenv.fish
```

Remember to create the directory if it's not already there `mkdir -p ~/.config/fish/completions/`.

Remember to open a new shell to test the functionality.
