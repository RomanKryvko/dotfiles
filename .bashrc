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
export PS1=$'\u256d─\[\e[32m\](\u\[\e[0m\]@\[\e[32m\]\h)\[\e[0m\]─[\[\e[94m\]\w\[\e[0m\]]\[\e[93m\]$(parse_git_branch)\n\[\e[0m\]\u2570─\$ '
