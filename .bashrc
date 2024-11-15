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

truncate_pwd () {
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
PROMPT_COMMAND=timer_stop
export PS1=$'┌─[\[\e[32m\]\u\[\e[0m\]@\[\e[32m\]\h:\[\e[94m\]$(truncate_pwd)\[\e[0m\]]─[\[\e[0m\]\[\e[32m\]$?\[\e[0m\]]─[\[\e[33m\]${timer_show}\[\e[0m\]]\[\e[93m\]$(parse_git_branch)\n\[\e[0m\]└─\$ '
