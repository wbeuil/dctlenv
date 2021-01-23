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

## Uninstalling dctlenv

You will need to first remove the line from your shell startup configuration file. This will remove dctlenv shims directory from your `$PATH`.

Then, you just need to remove its root directory:

```shell
$ rm -rf `dctlenv root`
```
