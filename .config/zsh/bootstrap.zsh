# bootstrap.zsh: only what's needed before zfuncs can load.
# Sourced by .zshrc. Keep this small; zfuncs must never depend on it.

# zfuncs_load: load a zfunc, optionally run it, and say so if anything fails.
# usage: zfuncs_load [--run] <function> [args...]
zfuncs_load() {
  local run=0 name
  if [[ $1 == --run ]]; then run=1; shift; fi
  name=$1
  [[ -n $name ]] || { print -u2 "zfuncs_load: usage: zfuncs_load [--run] <function> [args...]"; return 2 }
  shift

  autoload -Uz +X "$name" || { print -u2 "zfuncs_load: $name failed to load"; return 1 }
  (( run )) || return 0
  "$name" "$@" || { print -u2 "zfuncs_load: $name failed"; return 1 }
}

