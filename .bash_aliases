alias ls='ls --color=auto'
alias la='ls -lah'
alias ll='ls -lh'
alias grep='grep --color=auto'

alias nightmode='redshift -P -O 5000'
alias daymode='redshift -x'
alias pacupd='echo -e "\n$(date)\n$(checkupdates --nocolor)" >> $HOME/update-log.txt && sudo pacman -Syu'

if [ $WAYLAND_DISPLAY ]; then
    alias ccopy='wl-copy'
    alias cpaste='wl-paste'
else
    alias ccopy='xsel -ib'
    alias cpaste='xsel -ob'
fi


function _cb() {
    local cur
    cur="${COMP_WORDS[COMP_CWORD]}"
    COMPREPLY=( $(compgen -W "${PWD//\// }" -- ${cur}) )
    true
}

# stands for "Change (directory) Back"
# name conflicts with cb clipboard managment utility
function cb() {
    if [ ! $1 ]; then
        cd ..
    else
        dir=$(pwd | grep -oe ".*$1")
        cd ${dir:-$1}
    fi
}

complete -o nosort -F _cb cb

function _config() {
    if [ -d "$HOME/.config/" ]; then
        local cur
        cur="${COMP_WORDS[COMP_CWORD]}"
        COMPREPLY=( $(compgen -W "$(ls "$HOME/.config")" -- ${cur}) )
    fi
    true
}

function config() {
    if [ -d "$HOME/.config/$1" ]; then
        if [ $(ls -A "$HOME/.config/$1" | wc -l) -eq 1 ]; then
            $EDITOR $HOME/.config/$1/*
        else
            cd "$HOME/.config/$1"
        fi
    elif [ -f "$HOME/.config/$1" ]; then
        $EDITOR "$HOME/.config/$1"
    else
        echo "$1 does not exist in the .config directory."
        return 1
    fi
}

complete -F _config config
