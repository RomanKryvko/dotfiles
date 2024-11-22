alias ls='ls --color=auto'
alias la='ls -lah'
alias ll='ls -lh'
alias grep='grep --color=auto'

alias nightmode='redshift -P -O 5000'
alias daymode='redshift -x'
alias pacupd='echo -e "\n$(date)\n$(checkupdates --nocolor)" >> update-log.txt && sudo pacman -Syu'
alias ccopy='xsel -ib'
alias cpaste='xsel -ob'

function config() {
    if [ -d "$HOME/.config/$1" ]; then
        cd "$HOME/.config/$1"
        if [ $(ls -A | wc -l) -eq 1 ]; then
            $EDITOR *
        fi
    elif [ -f "$HOME/.config/$1" ]; then
        $EDITOR "$HOME/.config/$1"
    else
        echo "$1 does not exist in the .config directory."
    fi
}
