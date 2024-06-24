#!/usr/bin/env bash

setup_config_file() {
    local command_name="$1"
    local config_name="$2"

    if command -v "$command_name" >/dev/null 2>&1; then
        if [[ ! -f ".$config_name" ]]; then
            touch ".$config_name"
            if [[ -f "$HOME/.config/projects/user.$config_name" ]]; then
                cat "$HOME/.config/projects/user.$config_name" >> ".$config_name"
            fi
            if [[ -f "./local.$config_name" ]]; then
                cat "./local.$config_name" >> ".$config_name"
            fi
#            sort ".$config_name" | uniq > ".$config_name.tmp" && mv ".$config_name.tmp" ".$config_name"
        fi
    fi
}

setup_config_file "git" "gitattributes"
setup_config_file "git" "gitignore"
setup_config_file "direnv" "envrc"

