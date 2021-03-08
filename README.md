# dctlenv

![GitHub Workflow Status](https://img.shields.io/github/workflow/status/wbeuil/dctlenv/Test%20Workflow)
[![All Contributors](https://img.shields.io/badge/all_contributors-2-orange.svg)](#contributors-)

Version manager for [driftctl](https://github.com/cloudskiff/driftctl) inspired by [tfenv](https://github.com/tfutils/tfenv).

## Installation

### Basic GitHub Checkout

This will get you going with the latest version of dctlenv and make it easy to fork and contribute any changes back upstream.

**1. Check out dctlenv where you want**

```console
# Install latest version
$ git clone https://github.com/wbeuil/dctlenv ~/.dctlenv

# Install a specific version (e.g. v0.1.2)
$ git clone --depth 1 --branch v0.1.2 https://github.com/wbeuil/dctlenv ~/.dctlenv
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

Available options:

- `(v)x.y.z` to install the exact version of driftctl
- `latest` to install the latest version of driftctl

```console
$ dctlenv install 0.2.3
Installing driftctl v0.2.3
Downloading release tarball from https://github.com/cloudskiff/driftctl/releases/download/v0.2.3/driftctl_darwin_amd64
######################################################################################################################## 100.0%
Downloading SHA256 hashes file from https://github.com/cloudskiff/driftctl/releases/download/v0.2.3/driftctl_SHA256SUMS
No SHA256 hashes file available. Skipping SHA256 hash validation
Installation of driftctl v0.2.3 successful. To make this your default version, run 'dctlenv use 0.2.3'
```

For signed version of driftctl (starting v0.4.0) you can now install and verify digital signature with dctlenv.

You will need first to import the public key of CloudSkiff and then use the environment variable `DCTLENV_PGP`.

```console
# Import key
$ gpg --keyserver hkps.pool.sks-keyservers.net --recv-keys 0xACC776A79C824EBD
gpg: key ACC776A79C824EBD: public key "Cloudskiff <security@cloudskiff.com>" imported
gpg: Total number processed: 1
gpg:               imported: 1

# Install and verify signature
$ DCTLENV_PGP=1 dctlenv install 0.4.0
Installing driftctl v0.4.0
Downloading release tarball from https://github.com/cloudskiff/driftctl/releases/download/v0.4.0/driftctl_darwin_amd64
######################################################################################################################## 100.0%
Downloading SHA256 hashes file from https://github.com/cloudskiff/driftctl/releases/download/v0.4.0/driftctl_SHA256SUMS
SHA256 hash matched!
Downloading SHA256 hashes signature file from https://github.com/cloudskiff/driftctl/releases/download/v0.4.0/driftctl_SHA256SUMS.gpg
gpg: Signature made Mon Feb  8 18:59:40 2021 CET
gpg:                using EDDSA key 277666005A7F01D484F6376DACC776A79C824EBD
gpg:                issuer "security@cloudskiff.com"
gpg: Good signature from "Cloudskiff <security@cloudskiff.com>" [ultimate]
PGP signature matched!
Installation of driftctl v0.4.0 successful. To make this your default version, run 'dctlenv use 0.4.0'
```

### `dctlenv use [<version>]`

Switch a version to use.

Available options:

- `(v)x.y.z` to install and use the exact version of driftctl
- `latest` to install and use the latest version of driftctl

```console
$ dctlenv use 0.2.3
Switching version to v0.2.3
Switching completed

$ dctlenv use v0.6.0
Switching version to v0.6.0
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

Available options:

- `(v)x.y.z` to uninstall the exact version of driftctl

```console
$ dctlenv uninstall 0.2.3
Uninstall driftctl v0.2.3
driftctl v0.2.3 is successfully uninstalled

$ dctlenv uninstall v0.6.0
Uninstall driftctl v0.6.0
driftctl v0.6.0 is successfully uninstalled
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

## Environment variables

You can configure how `dctlenv` operates with the following settings:

| name            | default | description                                                                                 |
| --------------- | ------- | ------------------------------------------------------------------------------------------- |
| `DCTLENV_ROOT`  |         | Defines the directory under which dctlenv resides<br> Current value shown by `dctlenv root` |
| `DCTLENV_ARCH`  | `amd64` | Architecture other than the default amd64 can be specified                                  |
| `DCTLENV_DEBUG` | `0`     | Outputs debug information                                                                   |
| `DCTLENV_PGP`   | `0`     | Verify digital signatures                                                                   |

## Contributors ✨

Thanks goes to these wonderful people ([emoji key](https://allcontributors.org/docs/en/emoji-key)):

<!-- ALL-CONTRIBUTORS-LIST:START - Do not remove or modify this section -->
<!-- prettier-ignore-start -->
<!-- markdownlint-disable -->
<table>
  <tr>
    <td align="center"><a href="http://wbeuil.com"><img src="https://avatars.githubusercontent.com/u/8110579?v=4?s=100" width="100px;" alt=""/><br /><sub><b>William BEUIL</b></sub></a><br /><a href="#ideas-wbeuil" title="Ideas, Planning, & Feedback">🤔</a> <a href="https://github.com/wbeuil/dctlenv/commits?author=wbeuil" title="Code">💻</a> <a href="https://github.com/wbeuil/dctlenv/commits?author=wbeuil" title="Documentation">📖</a> <a href="#maintenance-wbeuil" title="Maintenance">🚧</a> <a href="https://github.com/wbeuil/dctlenv/pulls?q=is%3Apr+reviewed-by%3Awbeuil" title="Reviewed Pull Requests">👀</a></td>
    <td align="center"><a href="https://github.com/sjourdan"><img src="https://avatars.githubusercontent.com/u/419121?v=4?s=100" width="100px;" alt=""/><br /><sub><b>Stephane Jourdan</b></sub></a><br /><a href="https://github.com/wbeuil/dctlenv/commits?author=sjourdan" title="Documentation">📖</a></td>
  </tr>
</table>

<!-- markdownlint-restore -->
<!-- prettier-ignore-end -->

<!-- ALL-CONTRIBUTORS-LIST:END -->

This project follows the [all-contributors](https://github.com/all-contributors/all-contributors) specification. Contributions of any kind welcome!
