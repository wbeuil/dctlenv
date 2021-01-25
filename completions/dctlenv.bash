# bash completion for dctlenv

_dctlenv() {
  if [ "${#COMP_WORDS[@]}" != "2" ]; then
    return
  fi

  COMPREPLY=($(compgen -W "help install list list-remote uninstall use version" -- "${COMP_WORDS[1]}"))
}

complete -F _dctlenv dctlenv
