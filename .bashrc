#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias la='ls -lah'
alias grep='grep --color=auto'
alias nightmode='redshift -P -O 5000'
alias daymode='redshift -x'
alias pacupd='echo -e "\n" >> update-log.txt && date >> update-log.txt && checkupdates --nocolor >> update-log.txt && sudo pacman -Syu'
alias ccopy='xsel -ib'
alias cpaste='xsel -ob'

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
    if ($1 >= 1000000)
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
    local NAME=$PWD LENGTH=$(($COLUMNS-55))
    if [ ${#NAME} -gt $LENGTH ]; then
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
