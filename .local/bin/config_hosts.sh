#!/usr/bin/env zsh

if [[ -f ${HOME}/.ssh/hosts ]]; then
  hosts=($(perl ${HOME}/.local/bin/list_hosts.pl))
  host_dir=${XDG_STATE_HOME}/hosts
  for host in $hosts; do
    mkdir -p $host_dir/$host
  done
fi
