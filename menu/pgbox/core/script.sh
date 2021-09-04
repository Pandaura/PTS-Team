#!/bin/bash

IFS=$'\n'
# File name or path
APPS_FILE="apps.txt"

# Read file as array
apps=($(cat "$APPS_FILE"))

length=$((${#apps[@]} - 1))

index=0
# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m'

function print_list() {
    local count=0
    clear
    for i in ${apps[@]}; do
        if [[ $count -ne $index ]]; then
            echo -e "${RED}${i}"
        else
            echo -e "${GREEN}${i}"
        fi
        ((count++))
    done
    echo -ne "${NC}"
}
function your_code_here() {
    local app=$*
    echo "Your selected app: ${app} "
}

function select_app() {
    while read -sN1 key >/dev/null; do
        # catch multi-char special key sequences
        read -sN1 -t 0.0001 k1
        read -sN1 -t 0.0001 k2
        read -sN1 -t 0.0001 k3
        key+=${k1}${k2}${k3}

        case "$key" in
        $'\e[A' | $'\e0A' | $'\e[D' | $'\e0D') # cursor up, left: previous item

            if [[ $index -gt 0 ]]; then
                ((index--))
            fi
            ;;

        $'\e[B' | $'\e0B' | $'\e[C' | $'\e0C') # cursor down, right: next item

            if [[ $index -lt $length ]]; then
                ((index++))
            fi
            ;;
        $'\e[1~' | $'\e0H' | $'\e[H') # home: first item
            index=0
            ;;

        $'\e[4~' | $'\e0F' | $'\e[F') # end: last item
            index=$length
            ;;

        ' ') # space: mark/unmark item
            your_code_here "${apps[index]}"
            return 0
            ;;

        q | '') # q, carriage return: quit
            return 0 ;;
        esac
        print_list
    done
}

print_list
select_app
