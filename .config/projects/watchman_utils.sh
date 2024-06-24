#!/usr/bin/env bash

create_watchmanconfig() {
    USER_CONFIG="$HOME/.config/projects/user.watchmanconfig"
    LOCAL_CONFIG="local.watchmanconfig"

    merge_json() {
        local base="$1"
        local override="$2"
        if [ -f "$override" ] && [ -s "$override" ]; then
            jq -s '.[0] * .[1]' "$base" "$override"
        else
            cat "$base"
        fi
    }


    if [ ! -f "${USER_CONFIG}" ];then
        echo "ERROR: user.watchmanconfig not found"
        return 1
    fi
    
    merge_json "${USER_CONFIG}" "${LOCAL_CONFIG}" > .watchmanconfig

    if [ ! -f "${LOCAL_CONFIG}" ]; then
        touch local.watchmanconfig
        echo "Generating .watchmanconfig file"
        echo "please use local.watchmanconfig for modifications"
    fi
}

