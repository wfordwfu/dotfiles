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

# zfuncs_periodic: do something at most once per interval.
# usage: zfuncs_periodic <name> <interval> [--run] <command...>
#   interval: a number plus s, m, h or d (for example 1d)
#   --run:    when due, run the command in the background, output to a log
#   without:  when due, print a reminder to run it yourself
zfuncs_periodic() {
  local usage="zfuncs_periodic: usage: zfuncs_periodic <name> <interval> [--run] <command...>"
  (( $# >= 3 )) || { print -u2 $usage; return 2 }
  local name=$1 interval=$2 run=0
  shift 2
  if [[ $1 == --run ]]; then run=1; shift; fi
  if (( $# == 0 )) || [[ ! $interval =~ '^([0-9]+)([smhd])$' ]]; then
    print -u2 $usage; return 2
  fi

  local -A unit=(s 1 m 60 h 3600 d 86400)
  local seconds=$(( ${match[1]} * ${unit[${match[2]}]} ))
  local dir=${XDG_STATE_HOME:-$HOME/.local/state}/zsh/periodic
  local stamp=$dir/$name.stamp rc_file=$dir/$name.rc log=$dir/$name.log last=0

  zmodload zsh/datetime
  command mkdir -p "$dir" || return 1
  [[ -r $stamp ]] && last=$(<$stamp)

  if [[ -r $rc_file && $(<$rc_file) != 0 ]]; then
    print -u2 "zfuncs_periodic: last '$name' run failed, see $log"
    print -u2 "zfuncs_periodic: to re-run it in the next shell: rm $stamp"
  fi

  (( EPOCHSECONDS - last >= seconds )) || return 0
  print -r -- $EPOCHSECONDS >| $stamp

  if (( run )); then
    { "$@"; print -r -- $? >| $rc_file } >| $log 2>&1 &!
  else
    print "$name: due. Run: $*"
  fi
}
