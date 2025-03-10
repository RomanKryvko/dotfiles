#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

if [ -f ~/.bash_aliases ]; then
    source ~/.bash_aliases
fi

parse_git_branch() {
    if [ "$PWD" != "$HOME" ]; then
        git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
    fi
}

timer_start() {
    timer=${timer:-${EPOCHREALTIME/[^0-9]/}}
}

timer_stop() {
    timer_show=$(echo $((${EPOCHREALTIME/[^0-9]/} - $timer)) | awk '{
    if ($1 >= 60000000)
        {
            seconds = $1/1000000
            printf("%dm%ds", seconds/60, seconds%60)
        }
    else if ($1 >= 1000000)
        {
            printf("%.2fs", $1/1000000);
        }
    else
        {
            printf("%.2fms", $1/1000);
        }
    }')
    unset timer
}

truncate_pwd() {
    local NAME=$PWD LENGTH=$(($COLUMNS - 35))
    if [ ${#NAME} -gt $LENGTH ] && [ $NAME != $HOME ]; then
        local PARENT=$(dirname $NAME)
        NAME="/.../$(basename $PARENT)/$(basename $NAME)"
    else
        NAME=${NAME/#$HOME/\~}
    fi
    echo "$NAME"
}

trap 'timer_start' DEBUG
PROMPT_COMMAND=__prompt_command

__prompt_command() {
    local EXIT="$?"
    timer_stop
    local CLEAR_COL="\[\e[0m\]"
    local GREEN="\[\e[32m\]"
    local BLUE="\[\e[94m\]"
    local YELLOW="\[\e[93m\]"
    local RED="\[\e[31m\]"

    if [ $EXIT -eq 0 ]; then
        EXIT=""
    else
        EXIT="─[$RED$EXIT$CLEAR_COL]"
    fi

    PS1="┌─[$GREEN\u$CLEAR_COL@$GREEN\h:$BLUE$(truncate_pwd)$CLEAR_COL]$EXIT─[$YELLOW${timer_show}$CLEAR_COL]$YELLOW$(parse_git_branch)\n$CLEAR_COL└─\$ "
}

# Automatically added by the Guix install script.
if [ -n "$GUIX_ENVIRONMENT" ]; then
    if [[ $PS1 =~ (.*)"\\$" ]]; then
        PS1="${BASH_REMATCH[1]} [env]\\\$ "
    fi
fi

